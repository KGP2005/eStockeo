import 'package:flutter/material.dart';
import '../registro_controller.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/registro_ilustracion.dart';

class Paso3Contrasena extends StatefulWidget {
  final RegistroController controller;

  const Paso3Contrasena({Key? key, required this.controller}) : super(key: key);

  @override
  State<Paso3Contrasena> createState() => _Paso3ContrasenaState();
}

class _Paso3ContrasenaState extends State<Paso3Contrasena> {
  bool _mostrarContrasena = false;
  bool _mostrarConfirmacion = false;

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
            const RegistroIlustracion(paso: 3),
            
            const SizedBox(height: 32),
            
            // Indicador de paso
            RegistroProgressIndicator(pasoActual: widget.controller.pasoActual),
            
            const SizedBox(height: 40),
            
            // Campo: Contraseña
            AnimatedBuilder(
              animation: widget.controller.contrasenaController,
              builder: (context, _) {
                final contrasenaValida = widget.controller.contrasenaValida;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordField(
                      controller: widget.controller.contrasenaController,
                      hintText: 'Contraseña',
                      mostrar: _mostrarContrasena,
                      onToggleVisibility: () {
                        setState(() {
                          _mostrarContrasena = !_mostrarContrasena;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Al menos 8 caracteres, 1 mayúscula, 1 número y 1 símbolo',
                      style: TextStyle(
                        fontSize: 12,
                        color: contrasenaValida 
                            ? const Color(0xFF4CAF50) 
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Campo: Confirmación de contraseña
            AnimatedBuilder(
              animation: Listenable.merge([
                widget.controller.contrasenaController,
                widget.controller.confirmacionContrasenaController,
              ]),
              builder: (context, _) {
                final contrasena = widget.controller.contrasenaController.text;
                final confirmacion = widget.controller.confirmacionContrasenaController.text;
                final coinciden = contrasena.isNotEmpty && 
                                confirmacion.isNotEmpty && 
                                contrasena == confirmacion;
                
                return _buildPasswordField(
                  controller: widget.controller.confirmacionContrasenaController,
                  hintText: 'Confirmación de contraseña',
                  mostrar: _mostrarConfirmacion,
                  onToggleVisibility: () {
                    setState(() {
                      _mostrarConfirmacion = !_mostrarConfirmacion;
                    });
                  },
                  suffixIcon: coinciden
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                );
              },
            ),
            
            const SizedBox(height: 60),
            
            // Botón Siguiente
            AnimatedBuilder(
              animation: Listenable.merge([
                widget.controller.contrasenaController,
                widget.controller.confirmacionContrasenaController,
              ]),
              builder: (context, _) {
                final habilitado = widget.controller.paso3Completo;
                
                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: habilitado
                        ? () {
                            widget.controller.siguientePaso();
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool mostrar,
    required VoidCallback onToggleVisibility,
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
        obscureText: !mostrar,
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
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (suffixIcon != null) suffixIcon,
              IconButton(
                icon: Icon(
                  mostrar ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: const Color(0xFF9E9E9E),
                ),
                onPressed: onToggleVisibility,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
