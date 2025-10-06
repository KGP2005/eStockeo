import 'package:flutter/material.dart';
import '../registro_controller.dart';

class Paso1Correo extends StatelessWidget {
  final RegistroController controller;

  const Paso1Correo({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          
          // Indicador de paso
          _buildProgressIndicator(),
          
          const SizedBox(height: 24),
          
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
          Image.asset(
            'assets/images/registro_ilustracion.png',
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.person_add, size: 80, color: Colors.grey),
              );
            },
          ),
          
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
              final correoLleno = controller.correoController.text.isNotEmpty;
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
          
          const Spacer(),
          
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
                height: 56,
                child: ElevatedButton(
                  onPressed: habilitado
                      ? () {
                          controller.siguientePaso();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: habilitado
                        ? const Color(0xFF673AB7)
                        : Colors.grey[300],
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Siguiente',
                    style: TextStyle(
                      color: habilitado ? Colors.white : Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle('Correo', 0, isActive: true),
        _buildConnector(),
        _buildStepCircle('Datos', 1),
        _buildConnector(),
        _buildStepCircle('Contraseña', 2),
        _buildConnector(),
        _buildStepCircle('Políticas', 3),
      ],
    );
  }

  Widget _buildStepCircle(String label, int step, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF673AB7) : Colors.white,
            border: Border.all(
              color: isActive ? const Color(0xFF673AB7) : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Center(
            child: isActive
                ? const Icon(Icons.circle, color: Colors.white, size: 12)
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? const Color(0xFF673AB7) : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector() {
    return Container(
      width: 30,
      height: 2,
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.grey[300],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}