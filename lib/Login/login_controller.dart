import 'package:flutter/material.dart';
import 'login_service.dart';
import '../Screens/HomeExplorador.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Validación
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa tu correo y contraseña'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Intentar login
    final result = await _loginService.login(email, password);

    // Cerrar loading
    if (context.mounted) Navigator.pop(context);

    if (result['success']) {
      // Login exitoso
      print('Usuario logueado: ${result['user']?.email}');
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Bienvenido!'),
            backgroundColor: Colors.green,
          ),
        );
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeExplorador()),
        );
      }
    } else {
      // Login fallido
      String errorMessage = 'Credenciales incorrectas';
      
      // Mensajes de error más específicos
      if (result['error'] != null) {
        final error = result['error'].toString().toLowerCase();
        
        if (error.contains('invalid login credentials')) {
          errorMessage = 'Email o contraseña incorrectos';
        } else if (error.contains('email not confirmed')) {
          errorMessage = 'Por favor confirma tu email';
        } else if (error.contains('user not found')) {
          errorMessage = 'Usuario no encontrado';
        } else {
          errorMessage = 'Error: ${result['error']}';
        }
      }
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}