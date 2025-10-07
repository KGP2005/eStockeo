import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final int bolsaCantidad;
  final ValueChanged<int> onTap;

  const NavBar({
    Key? key,
    required this.currentIndex,
    required this.bolsaCantidad,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(_buildHomeIcon(), 'Inicio', 0, currentIndex == 0),
          _buildNavItem(_buildBagIcon(), 'Bolsa', 1, currentIndex == 1),
          _buildNavItem(_buildMessageIcon(), 'Mensajes', 2, currentIndex == 2),
          _buildNavItem(_buildPersonIcon(), 'Perfil', 3, currentIndex == 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(Widget icon, String label, int index, bool isActive) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey[400],
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeIcon() {
    return Image.asset(
      'assets/icons/home-2.png',
      width: 24,
      height: 24,
      color: currentIndex == 0 ? Colors.black : Colors.grey[400],
    );
  }

  Widget _buildBagIcon() {
    return Stack(
      children: [
        Image.asset(
          'assets/icons/shopping-bag-02.png',
          width: 24,
          height: 24,
          color: currentIndex == 1 ? Colors.black : Colors.grey[400],
        ),
        if (bolsaCantidad > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$bolsaCantidad',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMessageIcon() {
    return Image.asset(
      'assets/icons/message.png',
      width: 24, 
      height: 24,
      color: currentIndex == 2 ? Colors.black : Colors.grey[400],
    );
  }

  Widget _buildPersonIcon() {
    return Image.asset(
      'assets/icons/user.png',
      width: 24,
      height: 24,
      color: currentIndex == 3 ? Colors.black : Colors.grey[400],
    );
  }
}
