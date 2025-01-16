import 'package:chatapptuto/services/auth/auth_gate.dart';
import 'package:chatapptuto/firebase_options.dart';
import 'package:chatapptuto/services/chat/chat_services.dart';
import 'package:chatapptuto/themes/light_mode.dart';
import 'package:chatapptuto/themes/themes_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemesProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemesProvider>(context).themeData,
    );
  }
}

class LoginorRegister {}
