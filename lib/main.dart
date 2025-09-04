import 'package:flutter/material.dart';
import 'package:estockeo/Login-Registro/Login/login_page.dart';

// Este es el archivo principal de tu aplicación, típicamente llamado main.dart
void main() {
  runApp(const MyApp());
}

// La clase principal de la aplicación que envuelve tu página de inicio de sesión
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eStockeo App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Tu LoginPage es la página de inicio de la aplicación
      home: const LoginPage(),
    );
  }
}