import 'package:flutter/material.dart';

class RegistroIlustracion extends StatelessWidget {
  final int paso; // 1, 2, 3, 4

  const RegistroIlustracion({
    Key? key,
    required this.paso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mapear el paso a la imagen correspondiente
    String imagePath;
    
    switch (paso) {
      case 1:
        imagePath = 'assets/images/paso1.png';
        break;
      case 3:
        imagePath = 'assets/images/paso3.png'; // Usar la misma imagen o crear paso3.png
        break;
      default:
        imagePath = 'assets/images/paso1.png';
    }

    return Image.asset(
      imagePath,
      height: 180,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.person_add,
            size: 80,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
