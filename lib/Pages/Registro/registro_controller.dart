import 'package:flutter/material.dart';

class RegistroController extends ChangeNotifier {
  // Paso actual (0-3 para los 4 pasos)
  int _pasoActual = 0;

  // PASO 1: Correos
  final TextEditingController correoController = TextEditingController();
  final TextEditingController confirmacionCorreoController = TextEditingController();

  // PASO 2: Datos personales (agregar cuando llegues ahí)
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // PASO 3: Contraseña (agregar cuando llegues ahí)
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController confirmacionContrasenaController = TextEditingController();

  // PASO 4: Políticas (agregar cuando llegues ahí)
  bool aceptaPoliticas = false;
  bool aceptaTerminos = false;

  // Getters
  int get pasoActual => _pasoActual;

  // Validaciones para Paso 1
  bool get correoValido {
    final correo = correoController.text.trim();
    if (correo.isEmpty) return false;
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(correo);
  }

  bool get correosCoincidenYValidos {
    final correo = correoController.text.trim();
    final confirmacion = confirmacionCorreoController.text.trim();
    
    if (correo.isEmpty || confirmacion.isEmpty) return false;
    if (correo != confirmacion) return false;
    
    return correoValido;
  }

  bool get paso1Completo => correosCoincidenYValidos;

  // Métodos de navegación
  void siguientePaso() {
    if (_pasoActual < 3) {
      _pasoActual++;
      notifyListeners();
    }
  }

  void pasoAnterior() {
    if (_pasoActual > 0) {
      _pasoActual--;
      notifyListeners();
    }
  }

  void irAPaso(int paso) {
    if (paso >= 0 && paso <= 3) {
      _pasoActual = paso;
      notifyListeners();
    }
  }

  // Limpiar datos
  void limpiarFormulario() {
    correoController.clear();
    confirmacionCorreoController.clear();
    nombreController.clear();
    apellidoController.clear();
    usernameController.clear();
    contrasenaController.clear();
    confirmacionContrasenaController.clear();
    aceptaPoliticas = false;
    aceptaTerminos = false;
    _pasoActual = 0;
    notifyListeners();
  }

  // Registrar usuario (implementar después)
  Future<bool> registrarUsuario() async {
    // TODO: Implementar con Supabase
    return false;
  }

  @override
  void dispose() {
    correoController.dispose();
    confirmacionCorreoController.dispose();
    nombreController.dispose();
    apellidoController.dispose();
    usernameController.dispose();
    contrasenaController.dispose();
    confirmacionContrasenaController.dispose();
    super.dispose();
  }
}