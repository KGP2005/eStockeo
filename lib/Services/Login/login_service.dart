import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('=== INTENTANDO LOGIN ===');
      print('Email: $email');
      print('Password length: ${password.length}');
      
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      print('=== LOGIN EXITOSO ===');
      print('User ID: ${response.user?.id}');
      print('Email: ${response.user?.email}');
      print('Session: ${response.session != null}');
      
      return {
        'success': true,
        'user': response.user,
        'session': response.session,
      };
      
    } on AuthException catch (e) {
      print('=== ERROR DE AUTENTICACIÓN ===');
      print('Código: ${e.statusCode}');
      print('Mensaje: ${e.message}');
      
      return {
        'success': false,
        'error': e.message,
        'code': e.statusCode,
      };
      
    } catch (e) {
      print('=== ERROR GENERAL ===');
      print('Error: $e');
      
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }

  bool isLoggedIn() {
    return supabase.auth.currentUser != null;
  }
}