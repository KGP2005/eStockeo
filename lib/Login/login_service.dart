import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  Future<bool> login(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.session != null;
    } catch (e) {
      return false;
    }
  }
}