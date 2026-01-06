import 'package:echo_ledger_client/server_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../config/app_config.dart';

/// Global Serverpod client used throughout the Flutter app.
late final Client client;

/// Resolved server URL used to initialize the client.
late String serverUrl;

/// Initializes the global [client] instance.
///
/// - If [baseUrlOverride] is provided, it is used directly.
/// - Otherwise, loads the API URL from `assets/config.json`, unless overridden
///   by the `SERVER_URL` compile-time environment value.
/// - Configures [FlutterConnectivityMonitor] for network awareness.
/// - Configures [FlutterAuthSessionManager] for authentication.
Future<void> initServerpodClient({String? baseUrlOverride}) async {
  String resolvedUrl;
  if (baseUrlOverride != null && baseUrlOverride.isNotEmpty) {
    resolvedUrl = baseUrlOverride;
  } else {
    const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
    final config = await AppConfig.loadConfig();
    resolvedUrl = serverUrlFromEnv.isEmpty
        ? config.apiUrl ?? 'http://$localhost:8080/'
        : serverUrlFromEnv;
  }

  serverUrl = resolvedUrl;

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
}
