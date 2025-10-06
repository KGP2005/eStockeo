import 'package:estockeo_p1/Pages/Login/login_page.dart';
import 'package:estockeo_p1/Pages/Registro/registro_page.dart';
import 'package:estockeo_p1/Pages/Home_Explorador/HomeExplorador_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://znxnjzqfkkmhkbxdplvj.supabase.co', 
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpueG5qenFma2ttaGtieGRwbHZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkwMTgzNjQsImV4cCI6MjA3NDU5NDM2NH0.Yhd3GHyAK7JvQreMAm-YO6ZzbI5-vswL5wW6tLY09Dc', 
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eStockeo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/registro': (context) => const RegistroPage(),
        '/home_explorador': (context) => const HomeExplorador(),
      },
    );
  }
}