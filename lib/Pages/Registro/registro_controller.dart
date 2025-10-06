import 'package:flutter/material.dart';
import '../../Services/Registro/registro_service.dart';

class RegistroController extends ChangeNotifier {
  // Paso actual (0-3 para los 4 pasos)
  int _pasoActual = 0;

  // PASO 1: Correos
  final TextEditingController correoController = TextEditingController();
  final TextEditingController confirmacionCorreoController = TextEditingController();

  // PASO 2: Datos personales
  final TextEditingController nombreCompletoController = TextEditingController();
  final TextEditingController fechaNacimientoController = TextEditingController();
  String genero = '';
  String pais = '';
  String departamento = '';
  String provincia = '';
  String distrito = '';
  final TextEditingController celularController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  
  // Usuario (Paso 4)
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
    
    // Validación más estricta del email
    // Debe tener al menos 3 caracteres antes del @
    // Dominio válido con al menos 2 caracteres antes del punto
    final regex = RegExp(
      r'^[a-zA-Z0-9][\w\.-]{2,}@[a-zA-Z0-9][\w\.-]+\.[a-zA-Z]{2,}$'
    );
    
    return regex.hasMatch(correo);
  }

  bool get correosCoincidenYValidos {
    final correo = correoController.text.trim();
    final confirmacion = confirmacionCorreoController.text.trim();
    
    if (correo.isEmpty || confirmacion.isEmpty) return false;
    if (correo != confirmacion) return false;
    
    return correoValido;
  }

  bool get paso1Completo => correosCoincidenYValidos;

  // Validaciones para Paso 2
  bool get paso2Completo {
    return nombreCompletoController.text.trim().isNotEmpty &&
           fechaNacimientoController.text.trim().isNotEmpty &&
           genero.isNotEmpty &&
           pais.isNotEmpty &&
           departamento.isNotEmpty &&
           provincia.isNotEmpty &&
           distrito.isNotEmpty &&
           celularController.text.trim().isNotEmpty &&
           direccionController.text.trim().isNotEmpty;
  }

  // Métodos setter para Paso 2
  void setFechaNacimiento(DateTime fecha) {
    fechaNacimientoController.text = 
        '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
    notifyListeners();
  }

  void setGenero(String value) {
    genero = value;
    notifyListeners();
  }

  void setPais(String value) {
    pais = value;
    notifyListeners();
  }

  void setDepartamento(String value) {
    departamento = value;
    notifyListeners();
  }

  void setProvincia(String value) {
    provincia = value;
    notifyListeners();
  }

  void setDistrito(String value) {
    distrito = value;
    notifyListeners();
  }

  // Validaciones para Paso 3
  bool get contrasenaValida {
    final contrasena = contrasenaController.text;
    if (contrasena.isEmpty) return false;
    
    // Al menos 8 caracteres, una mayúscula, una minúscula, un número y un símbolo
    return contrasena.length >= 8 &&
           RegExp(r'[A-Z]').hasMatch(contrasena) &&
           RegExp(r'[a-z]').hasMatch(contrasena) &&
           RegExp(r'[0-9]').hasMatch(contrasena) &&
           RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(contrasena);
  }

  bool get contrasenasCoinciden {
    final contrasena = contrasenaController.text;
    final confirmacion = confirmacionContrasenaController.text;
    
    if (contrasena.isEmpty || confirmacion.isEmpty) return false;
    return contrasena == confirmacion;
  }

  bool get paso3Completo => contrasenaValida && contrasenasCoinciden;

  // Validaciones para Paso 4
  bool get usernameValido {
    final username = usernameController.text.trim();
    return username.length >= 3;
  }

  bool get paso4Completo => usernameValido && aceptaPoliticas;

  void setAceptaPoliticas(bool value) {
    aceptaPoliticas = value;
    notifyListeners();
  }

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
    nombreCompletoController.clear();
    fechaNacimientoController.clear();
    genero = '';
    pais = '';
    departamento = '';
    provincia = '';
    distrito = '';
    celularController.clear();
    direccionController.clear();
    usernameController.clear();
    contrasenaController.clear();
    confirmacionContrasenaController.clear();
    aceptaPoliticas = false;
    aceptaTerminos = false;
    _pasoActual = 0;
    notifyListeners();
  }

  // Registrar usuario en Supabase y guardar datos en la tabla 'usuarios'.
  Future<String?> registrarUsuario() async {
    final service = RegistroService();
    final email = correoController.text.trim();
    final password = contrasenaController.text;
    final datos = {
      'name': nombreCompletoController.text.trim(), // Cambiado de 'nombre_completo' a 'name'
      'fecha_nacimiento': fechaNacimientoController.text.trim(),
      'genero': genero,
      'pais': pais,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
      'celular': celularController.text.trim(),
      'direccion': direccionController.text.trim(),
      'username': usernameController.text.trim(),
    };
    return await service.registrarUsuario(
      email: email,
      password: password,
      datos: datos,
    );
  }

  @override
  void dispose() {
    correoController.dispose();
    confirmacionCorreoController.dispose();
    nombreCompletoController.dispose();
    fechaNacimientoController.dispose();
    celularController.dispose();
    direccionController.dispose();
    usernameController.dispose();
    contrasenaController.dispose();
    confirmacionContrasenaController.dispose();
    super.dispose();
  }
}