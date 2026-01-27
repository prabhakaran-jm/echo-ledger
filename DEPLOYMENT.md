# Echo Ledger - Deployment Guide

## Overview

Echo Ledger can be deployed to Serverpod Cloud (if you have beta access from the hackathon) or using alternative methods like Docker, Google Cloud Run, or AWS.

---

## Option 1: Serverpod Cloud 

**Status:** Serverpod Cloud is in private beta. If you received hackathon credits, you should have access.

### Prerequisites

1. **Access to Serverpod Cloud** (check your hackathon email)
2. **Serverpod CLI** installed: `dart pub global activate serverpod_cli`
3. **GitHub repository** (your code should be pushed)

### Steps

1. **Install Serverpod Cloud CLI:**
   ```bash
   dart pub global activate serverpod_cloud_cli
   ```

2. **Login to Serverpod Cloud:**
   ```bash
   scloud auth login
   ```
   (Opens browser to authenticate.)

3. **First time: Launch (create project)**  
   Only if you don’t have a project yet:
   ```bash
   cd server/echo_ledger_server   # or run from repo root
   scloud launch
   ```
   Hackathon plans typically allow **1 project**. If you see “The maximum number of projects that can be created has been reached (1)”, you already have a project — use **deploy** instead (below).

4. **Deploy to existing project:**  
   Use this to push new code to an existing Cloud project (e.g. `echo-ledger`):
   ```bash
   cd server/echo_ledger_server
   # Build Flutter web first so UI changes are included (or use ./scripts/deploy-with-ui.sh)
   serverpod run flutter_build
   scloud deploy
   ```
   When prompted:
   - Run `serverpod generate` before deploy: **Y**
   - Add `flutter_build` as pre-deploy hook: **Y** (builds Flutter web into `web/app`)

   **If UI changes don’t show after deploy**, run `serverpod run flutter_build` from `server/echo_ledger_server` before `scloud deploy`, or use `./scripts/deploy-with-ui.sh` (see Troubleshooting).
   
   To inspect/use your project: https://console.serverpod.cloud/projects

5. **Configure Production Settings (if needed):**
   
   Update `config/production.yaml` with your domain if you have one; Serverpod Cloud can also provide one.

6. **Production Passwords:**
   
   Serverpod Cloud manages database/Redis. For app secrets (JWT, email pepper, etc.), use the Cloud console or set them via the project’s secret/config. Locally you’d use `config/passwords.yaml` or env vars only for non-Cloud runs.

7. **Update Flutter App:**
   
   Once deployed, update your Flutter app's server URL to point to the deployed API:
   ```dart
   // In lib/main.dart or via config.json
   final serverUrl = 'https://your-app.serverpod.cloud/';
   ```

**Note:** Serverpod Cloud handles database, Redis, SSL, and scaling automatically.

---

## Option 2: Docker Deployment

Deploy using the included Dockerfile to any Docker-compatible platform (AWS ECS, Google Cloud Run, DigitalOcean, etc.).

### Build Docker Image

```bash
cd server/echo_ledger_server

# Build the image
docker build -t echo-ledger-server:latest .

# Test locally
docker run -p 8080:8080 \
  -e SERVERPOD_PASSWORD_database=your_db_password \
  -e SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper=your_jwt_pepper \
  -e SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey=your_jwt_key \
  -e SERVERPOD_PASSWORD_emailSecretHashPepper=your_email_pepper \
  echo-ledger-server:latest
```

### Deploy to Google Cloud Run

```bash
# Set your project
gcloud config set project YOUR_PROJECT_ID

# Build and push to Container Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/echo-ledger-server

# Deploy to Cloud Run
gcloud run deploy echo-ledger-server \
  --image gcr.io/YOUR_PROJECT_ID/echo-ledger-server \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars="SERVERPOD_PASSWORD_database=...,SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper=..."
```

**Important:** Cloud Run requires:
- Stateless servers (no in-memory state)
- No future calls (or use external scheduler)
- Database accessible from Cloud Run (Cloud SQL with public IP or VPC connector)

---

## Option 3: Manual Server Deployment

### Prerequisites

- Server with Dart runtime
- PostgreSQL database
- Redis (optional, can be disabled)
- Domain name with SSL certificate

### Steps

1. **Build Server Executable:**
   ```bash
   cd server/echo_ledger_server
   dart pub get
   dart compile exe bin/main.dart -o bin/server
   ```

2. **Copy Files to Server:**
   ```bash
   scp -r bin/server config/ migrations/ web/ lib/src/generated/protocol.yaml user@server:/opt/echo-ledger/
   ```

3. **Set Environment Variables:**
   ```bash
   export SERVERPOD_PASSWORD_database=your_db_password
   export SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper=your_jwt_pepper
   export SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey=your_jwt_key
   export SERVERPOD_PASSWORD_emailSecretHashPepper=your_email_pepper
   export SERVERPOD_PASSWORD_serviceSecret=your_service_secret
   ```

4. **Run Server:**
   ```bash
   ./server --mode=production --apply-migrations
   ```

5. **Set up Process Manager (systemd):**
   ```ini
   # /etc/systemd/system/echo-ledger.service
   [Unit]
   Description=Echo Ledger Serverpod Server
   After=network.target

   [Service]
   Type=simple
   User=serverpod
   WorkingDirectory=/opt/echo-ledger
   ExecStart=/opt/echo-ledger/server --mode=production
   Restart=always
   Environment="SERVERPOD_PASSWORD_database=..."
   # ... other env vars

   [Install]
   WantedBy=multi-user.target
   ```

---

## Production Configuration Checklist

### 1. Update `config/production.yaml`

- Set `publicHost` to your domain
- Set `publicPort` to 443 (HTTPS)
- Set `publicScheme` to https
- Configure database host (if not using Serverpod Cloud)
- Enable Redis if needed

### 2. Set Production Passwords

**Option A: Environment Variables (Recommended)**
```bash
export SERVERPOD_PASSWORD_database=strong_password_here
export SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper=random_32_chars_min
export SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey=random_64_chars_min
export SERVERPOD_PASSWORD_emailSecretHashPepper=random_32_chars_min
export SERVERPOD_PASSWORD_serviceSecret=random_20_chars_min
```

**Option B: `config/passwords.yaml`** (ensure it's gitignored!)
```yaml
production:
  database: 'strong_password_here'
  jwtRefreshTokenHashPepper: 'random_32_chars_min'
  jwtHmacSha512PrivateKey: 'random_64_chars_min'
  emailSecretHashPepper: 'random_32_chars_min'
  serviceSecret: 'random_20_chars_min'
```

### 3. Update Flutter App

**Option A: Build-time configuration**
```dart
// lib/main.dart
final serverUrl = const String.fromEnvironment(
  'SERVER_URL',
  defaultValue: 'https://your-api-domain.com/',
);
```

**Option B: Runtime configuration**
```dart
// Load from config.json or environment
final config = await AppConfig.loadConfig();
final serverUrl = config.apiUrl ?? 'https://your-api-domain.com/';
```

**Option C: Update `assets/config.json`**
```json
{
  "apiUrl": "https://your-api-domain.com"
}
```

### 4. Database Migrations

Ensure migrations are applied:
```bash
dart run bin/main.dart --apply-migrations --mode=production
```

Or set `SERVERPOD_APPLY_MIGRATIONS=true` in production.

### 5. Seed Demo Data (Optional)

If you want demo data in production (not recommended for real apps):
- The `seedDemoData` endpoint checks for production mode
- You may need to temporarily allow seeding or use a migration script

---

## Security Checklist

- [ ] Use strong, unique passwords for all secrets
- [ ] Enable SSL/TLS (HTTPS) in production
- [ ] Set `requireSsl: true` for database connections
- [ ] Never commit `passwords.yaml` to git (already in `.gitignore`)
- [ ] Use environment variables for secrets when possible
- [ ] Enable rate limiting (already implemented in your endpoints)
- [ ] Review and restrict CORS if serving web app
- [ ] Set up monitoring/logging (Serverpod Insights)

---

## Troubleshooting

### UI changes not reflecting after `scloud deploy`

The Flutter web app lives in `web/app`, which is built by `serverpod run flutter_build`. That build is gitignored, so it must exist **before** upload and be explicitly included (`.scloudignore` opts it back in). If the pre-deploy `flutter_build` doesn’t run or fails (e.g. no Flutter in the environment), the deployed UI can stay stale.

**Do this to ship UI changes reliably:**

1. **Build then deploy** from the server directory:
   ```bash
   cd server/echo_ledger_server
   serverpod run flutter_build
   scloud deploy
   ```
   Or use the helper script (same effect):
   ```bash
   ./scripts/deploy-with-ui.sh
   ```
   from `server/echo_ledger_server`, or `server/echo_ledger_server/scripts/deploy-with-ui.sh` from the repo root.

2. **If it still looks old:** try a hard refresh (Ctrl+Shift+R / Cmd+Shift+R) or an incognito window to rule out browser or CDN cache.

### Connection Issues

- **Flutter app can't connect:** Check CORS settings, verify server URL
- **Database connection fails:** Check firewall rules, SSL settings, credentials
- **Redis connection fails:** Ensure Redis is enabled and accessible

### Migration Issues

- **Migrations not applying:** Check `SERVERPOD_APPLY_MIGRATIONS` env var
- **Migration conflicts:** Review migration history, may need to reset in dev

### Performance

- **Slow queries:** Check database indexes, review query patterns
- **High memory:** Review caching strategy, check for memory leaks

---

## Next Steps

1. **Choose deployment method** based on your needs:
   - **Serverpod Cloud:** Easiest, managed service (if you have access)
   - **Docker:** Flexible, works anywhere
   - **Manual:** Full control, more setup

2. **Set up production secrets** securely

3. **Test deployment** in staging first

4. **Update Flutter app** to point to production API

5. **Monitor** using Serverpod Insights

---

## Resources

- [Serverpod Deployment Docs](https://docs.serverpod.dev/get-started/deployment)
- [Serverpod Cloud Signup](https://forms.gle/JgFCqW3NY6WdDfct5) (if you need access)
- [Serverpod Discord](https://discord.gg/wJ4pQeHhVc) (for support)
