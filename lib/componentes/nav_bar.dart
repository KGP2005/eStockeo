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
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey[600],
      onTap: onTap,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_bag),
              if (bolsaCantidad > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 16, minHeight: 16),
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
          ),
          label: 'Bolsa',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Mensajes',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
