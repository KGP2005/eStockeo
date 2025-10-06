import 'package:flutter/material.dart';

class RegistroProgressIndicator extends StatelessWidget {
  final int pasoActual; // 0, 1, 2, 3

  const RegistroProgressIndicator({
    Key? key,
    required this.pasoActual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle('Correo', 0),
        _buildConnector(0),
        _buildStepCircle('Datos', 1),
        _buildConnector(1),
        _buildStepCircle('Contraseña', 2),
        _buildConnector(2),
        _buildStepCircle('Políticas', 3),
      ],
    );
  }

  Widget _buildStepCircle(String label, int step) {
    final bool isCompleted = step < pasoActual;
    final bool isActive = step == pasoActual;
    
    Color circleColor;
    Color borderColor;
    Color textColor;
    Widget? icon;

    if (isCompleted) {
      // Paso completado: fondo morado, check blanco
      circleColor = const Color(0xFF5D4FB5);
      borderColor = const Color(0xFF5D4FB5);
      textColor = const Color(0xFF5D4FB5);
      icon = const Icon(Icons.check, color: Colors.white, size: 20);
    } else if (isActive) {
      // Paso actual: fondo morado, check blanco
      circleColor = const Color(0xFF5D4FB5);
      borderColor = const Color(0xFF5D4FB5);
      textColor = const Color(0xFF5D4FB5);
      icon = const Icon(Icons.check, color: Colors.white, size: 20);
    } else {
      // Paso futuro: fondo blanco, sin icono
      circleColor = Colors.white;
      borderColor = const Color(0xFFD1D1D1);
      textColor = const Color(0xFF9E9E9E);
      icon = null;
    }

    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Center(child: icon),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: textColor,
            fontWeight: isActive || isCompleted ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(int step) {
    // El conector está activo si el paso siguiente ya está completado
    final bool isActive = step < pasoActual;
    
    return Container(
      width: 24,
      height: 2,
      margin: const EdgeInsets.only(bottom: 30),
      color: isActive ? const Color(0xFF5D4FB5) : const Color(0xFFD1D1D1),
    );
  }
}
