import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../registro_controller.dart';
import '../widgets/progress_indicator.dart';

class Paso4Politicas extends StatelessWidget {
  final RegistroController controller;

  const Paso4Politicas({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Título
            const Text(
              'Crear una cuenta',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Indicador de paso
            RegistroProgressIndicator(pasoActual: controller.pasoActual),
            
            const SizedBox(height: 40),
            
            // Campo: Nombre de usuario
            AnimatedBuilder(
              animation: controller.usernameController,
              builder: (context, _) {
                final usernameValido = controller.usernameValido;
                
                return _buildTextField(
                  controller: controller.usernameController,
                  hintText: 'Usuario',
                  suffixIcon: usernameValido
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Checkbox: Términos y Condiciones
            AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: controller.aceptaPoliticas,
                      onChanged: (value) {
                        controller.setAceptaPoliticas(value ?? false);
                      },
                      activeColor: const Color(0xFF5D4FB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            children: [
                              const TextSpan(text: 'He leído y acepto los '),
                              TextSpan(
                                text: 'Términos y Condiciones',
                                style: const TextStyle(
                                  color: Color(0xFF5D4FB5),
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _mostrarTerminos(context);
                                  },
                              ),
                              const TextSpan(text: ' y '),
                              TextSpan(
                                text: 'Política de Privacidad',
                                style: const TextStyle(
                                  color: Color(0xFF5D4FB5),
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _mostrarPolitica(context);
                                  },
                              ),
                              const TextSpan(text: ' de eStockeo'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 60),
            
            // Botón Siguiente
            AnimatedBuilder(
              animation: Listenable.merge([
                controller.usernameController,
                controller,
              ]),
              builder: (context, _) {
                final habilitado = controller.paso4Completo;
                
                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: habilitado
                        ? () async {
                            await _finalizarRegistro(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: habilitado
                          ? const Color(0xFF5D4FB5)
                          : const Color(0xFFE8E8E8),
                      disabledBackgroundColor: const Color(0xFFE8E8E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Siguiente',
                      style: TextStyle(
                        color: habilitado ? Colors.white : const Color(0xFFA0A0A0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  void _mostrarTerminos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const SingleChildScrollView(
          child: Text(
            'Aquí irían los Términos y Condiciones de eStockeo.\n\n'
            'Este es un texto de ejemplo que debería ser reemplazado '
            'con los términos reales de tu aplicación.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cerrar',
              style: TextStyle(color: Color(0xFF5D4FB5)),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarPolitica(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Política de Privacidad'),
        content: const SingleChildScrollView(
          child: Text(
            'Aquí iría la Política de Privacidad de eStockeo.\n\n'
            'Este es un texto de ejemplo que debería ser reemplazado '
            'con la política real de tu aplicación.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cerrar',
              style: TextStyle(color: Color(0xFF5D4FB5)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _finalizarRegistro(BuildContext context) async {
    // Mostrar indicador de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF5D4FB5),
        ),
      ),
    );

    // Intentar registrar usuario
    final resultado = await controller.registrarUsuario();

    // Cerrar indicador de carga
    if (context.mounted) {
      Navigator.pop(context);
    }

    if (resultado) {
      // Registro exitoso - navegar a Home Explorador
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home_explorador');
      }
    } else {
      // Error en el registro
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al crear la cuenta. Por favor intenta de nuevo.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
