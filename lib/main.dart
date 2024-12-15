import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serene_app/app.dart';
import 'package:serene_app/design/app_theme.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the required FirebaseOptions for web
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDUx1CyHNWLbTivftCdThUkTCwGsOzNpjg",
      authDomain: "fir-web-app-9b3c9.firebaseapp.com",
      projectId: "fir-web-app-9b3c9",
      storageBucket: "fir-web-app-9b3c9.appspot.com",
      messagingSenderId: "1013873175193",
      appId: "1:1013873175193:web:a30b1098f28c638b05e608",
      measurementId: "G-QWERVL9ZKP",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lighThemeData,
      home: const AppPage(),
    );
  }
}
