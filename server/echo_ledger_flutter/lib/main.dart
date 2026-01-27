import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

import 'services/serverpod_client.dart';
import 'screens/friction_projection_screen.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // For web: use config.json (production) or localhost (dev)
  // For desktop: use localhost
  // For Android: use 10.0.2.2 (emulator)
  String? serverUrlOverride;
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    // Android emulator needs special IP
    serverUrlOverride = 'http://10.0.2.2:8080/';
  } else if (!kIsWeb) {
    // Desktop (Linux/macOS/Windows) - use localhost
    serverUrlOverride = 'http://localhost:8080/';
  }
  // For web: let it load from config.json (production) or use localhost fallback

  await initServerpodClient(baseUrlOverride: serverUrlOverride);
  client.auth.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo Ledger',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _AppEntry(),
    );
  }
}

/// Shows onboarding once, then the projection screen.
class _AppEntry extends StatefulWidget {
  const _AppEntry();

  @override
  State<_AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<_AppEntry> {
  bool _showOnboarding = true;

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnboardingScreen(
        onDone: () => setState(() => _showOnboarding = false),
      );
    }
    return const FrictionProjectionScreen();
  }
}
