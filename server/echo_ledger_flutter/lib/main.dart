import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'services/serverpod_client.dart';
import 'screens/friction_projection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Use localhost for web/desktop, 10.0.2.2 for Android emulator
  final serverUrl = kIsWeb 
      ? 'http://localhost:8080/'
      : 'http://10.0.2.2:8080/';
  
  await initServerpodClient(baseUrlOverride: serverUrl);
  client.auth.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FrictionProjectionScreen(),
    );
  }
}
