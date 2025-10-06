import 'package:flutter/material.dart';
import '../registro_controller.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/registro_ilustracion.dart';

class Paso1Correo extends StatelessWidget {
  final RegistroController controller;

  const Paso1Correo({Key? key, required this.controller}) : super(key: key);

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
            
            const SizedBox(height: 32),
            
            // Ilustración
            const RegistroIlustracion(paso: 1),
            
            const SizedBox(height: 32),
            
            // Indicador de paso
            RegistroProgressIndicator(pasoActual: controller.pasoActual),
            
            const SizedBox(height: 40),
            
            // Campo: Correo
            _buildTextField(
              controller: controller.correoController,
              hintText: 'Correo',
              keyboardType: TextInputType.emailAddress,
            ),
            
            const SizedBox(height: 16),
            
            // Campo: Confirmación de correo
            AnimatedBuilder(
              animation: controller.correoController,
              builder: (context, _) {
                final correosCoindicen = controller.correosCoincidenYValidos;
                
                return _buildTextField(
                  controller: controller.confirmacionCorreoController,
                  hintText: 'Confirmación de correo',
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: correosCoindicen
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                );
              },
            ),
            
            const SizedBox(height: 60),
            
            // Botón Siguiente
            AnimatedBuilder(
              animation: Listenable.merge([
                controller.correoController,
                controller.confirmacionCorreoController,
              ]),
              builder: (context, _) {
                final habilitado = controller.paso1Completo;
                
                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: habilitado
                        ? () {
                            controller.siguientePaso();
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
    TextInputType keyboardType = TextInputType.text,
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
        keyboardType: keyboardType,
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
}