import 'package:flutter/material.dart';

class CustomIcons {
  // Icono de casa (home) - coincidiendo con la imagen
  static Widget homeIcon({Color color = Colors.white, double size = 24}) {
    return CustomPaint(
      size: Size(size, size),
      painter: HomeIconPainter(color: color),
    );
  }

  // Icono de bolsa (shopping bag) - coincidiendo con la imagen
  static Widget bagIcon({Color color = Colors.white, double size = 24}) {
    return CustomPaint(
      size: Size(size, size),
      painter: BagIconPainter(color: color),
    );
  }

  // Icono de persona (profile) - coincidiendo con la imagen
  static Widget personIcon({Color color = Colors.white, double size = 24}) {
    return CustomPaint(
      size: Size(size, size),
      painter: PersonIconPainter(color: color),
    );
  }

  // Icono de mensaje (chat bubble) - coincidiendo con la imagen
  static Widget messageIcon({Color color = Colors.white, double size = 24}) {
    return CustomPaint(
      size: Size(size, size),
      painter: MessageIconPainter(color: color),
    );
  }
}

class HomeIconPainter extends CustomPainter {
  final Color color;

  HomeIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    
    // Casa con esquinas redondeadas
    // Techo
    path.moveTo(size.width * 0.2, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.3, size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width * 0.8, size.height * 0.4);
    
    // Paredes
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.85, size.width * 0.75, size.height * 0.85);
    path.lineTo(size.width * 0.75, size.height * 0.6);
    
    // Puerta (abertura en la parte inferior)
    path.moveTo(size.width * 0.65, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.85, size.width * 0.6, size.height * 0.85);
    path.lineTo(size.width * 0.4, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.85, size.width * 0.35, size.height * 0.6);
    
    // Pared izquierda
    path.moveTo(size.width * 0.2, size.height * 0.4);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.85, size.width * 0.25, size.height * 0.85);
    path.lineTo(size.width * 0.35, size.height * 0.85);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BagIconPainter extends CustomPainter {
  final Color color;

  BagIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    
    // Bolsa con forma trapezoidal redondeada
    // Asa
    path.moveTo(size.width * 0.3, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.1, size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.1, size.width * 0.7, size.height * 0.2);
    
    // Cuerpo de la bolsa (trapezoidal)
    path.moveTo(size.width * 0.25, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.25, size.width * 0.2, size.height * 0.3);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.85, size.width * 0.25, size.height * 0.85);
    path.lineTo(size.width * 0.75, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.85, size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.25, size.width * 0.75, size.height * 0.2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PersonIconPainter extends CustomPainter {
  final Color color;

  PersonIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    
    // Cabeza (círculo)
    path.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.5, size.height * 0.3),
      radius: size.width * 0.15,
    ));
    
    // Cuerpo (rectángulo redondeado)
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.25,
        size.height * 0.5,
        size.width * 0.5,
        size.height * 0.4,
      ),
      const Radius.circular(8),
    ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MessageIconPainter extends CustomPainter {
  final Color color;

  MessageIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    
    // Burbuja de chat redondeada
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.1,
        size.height * 0.1,
        size.width * 0.8,
        size.height * 0.7,
      ),
      const Radius.circular(12),
    ));
    
    // Cola de la burbuja
    path.moveTo(size.width * 0.4, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height * 0.9);
    path.lineTo(size.width * 0.6, size.height * 0.8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
