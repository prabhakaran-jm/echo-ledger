#!/usr/bin/env bash
# Build the Flutter web app, then deploy to Serverpod Cloud.
# Use this when UI changes are not reflecting after plain `scloud deploy`.
# Run from server/echo_ledger_server or from repo root.
# Requires: flutter on PATH. serverpod and scloud from PATH or ~/.pub-cache/bin.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FLUTTER_DIR="$SERVER_DIR/../echo_ledger_flutter"
cd "$SERVER_DIR"

# Ensure serverpod/scloud on PATH (e.g. from dart pub global activate)
if ! command -v serverpod &>/dev/null || ! command -v scloud &>/dev/null; then
  export PATH="${HOME}/.pub-cache/bin:${PATH}"
fi

echo "==> Regenerating server/client code (serverpod generate)..."
if ! command -v serverpod &>/dev/null; then
  echo "serverpod not found. Install with: dart pub global activate serverpod_cli"
  echo "Then ensure \$HOME/.pub-cache/bin is on your PATH."
  exit 1
fi
serverpod generate

echo "==> Building Flutter web app (output: web/app)..."
if (cd "$FLUTTER_DIR" && flutter build web --base-href /app/ --wasm); then
  :
elif (cd "$FLUTTER_DIR" && flutter build web --base-href /app/); then
  :
else
  echo "Flutter web build failed."
  exit 1
fi
rm -rf "$SERVER_DIR/web/app"
mv "$FLUTTER_DIR/build/web" "$SERVER_DIR/web/app"

echo "==> Deploying to Serverpod Cloud..."
if ! command -v scloud &>/dev/null; then
  export PATH="${HOME}/.pub-cache/bin:${PATH}"
fi
if ! command -v scloud &>/dev/null; then
  echo "scloud not found. Install with: dart pub global activate serverpod_cloud_cli"
  echo "Then ensure \$HOME/.pub-cache/bin is on your PATH, or run from this directory:"
  echo "  scloud deploy"
  exit 1
fi
scloud deploy
