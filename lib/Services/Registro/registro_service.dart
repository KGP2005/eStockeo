import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroService {
  final _supabase = Supabase.instance.client;

  /// Registra un usuario en Supabase Auth y guarda sus datos en la tabla 'usuarios'.
  Future<String?> registrarUsuario({
    required String email,
    required String password,
    required Map<String, dynamic> datos,
  }) async {
    try {
      // 1. Crear usuario en Supabase Auth (autoconfirmado)
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null, // Sin confirmación por correo
      );
      
      final user = authResponse.user;
      if (user == null) {
        return 'No se pudo crear el usuario. Verifica tu correo o intenta con otro.';
      }

      print('✅ Usuario creado en Auth: ${user.id}');
      print('📧 Email: ${user.email}');

      // 2. Esperar un momento para que el trigger cree el registro básico
      await Future.delayed(const Duration(milliseconds: 800));

      // 3. Actualizar los datos adicionales en la tabla 'users'
      print('📝 Intentando actualizar datos del usuario...');
      print('Datos a guardar: $datos');
      
      final response = await _supabase.from('users').update({
        'name': datos['name'], // Cambiado de 'nombre_completo' a 'name'
        'fecha_nacimiento': datos['fecha_nacimiento'],
        'genero': datos['genero'],
        'pais': datos['pais'],
        'departamento': datos['departamento'],
        'provincia': datos['provincia'],
        'distrito': datos['distrito'],
        'celular': datos['celular'],
        'direccion': datos['direccion'],
        'username': datos['username'],
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', user.id).select();

      print('✅ Datos actualizados correctamente');
      print('Respuesta: $response');
      
      return null; // null = éxito
    } on AuthException catch (e) {
      print('❌ Error de autenticación: ${e.message}');
      // Errores específicos de autenticación
      if (e.message.contains('already registered')) {
        return 'Este correo ya está registrado. Intenta iniciar sesión.';
      }
      return 'Error de autenticación: ${e.message}';
    } on PostgrestException catch (e) {
      print('❌ Error de base de datos: ${e.message}');
      print('Detalles: ${e.details}');
      // Errores de la base de datos
      return 'Error al guardar datos: ${e.message}';
    } catch (e) {
      print('❌ Error inesperado: $e');
      return 'Error inesperado: $e';
    }
  }
}