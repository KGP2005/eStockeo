import 'package:flutter/material.dart';
import '../Home_Explorador/HomeExplorador_page.dart';
import '../Carrito/carrito_page.dart';
import '../PerfilExporador/PerfilExplorador_page.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  int _bolsaCantidad = 0;

  // 🔹 Lista de productos añadidos
  List<Map<String, dynamic>> _productosBolsa = [];

  // 🔹 Método para agregar productos
  void _agregarABolsa(Map<String, dynamic> producto) {
    setState(() {
      _productosBolsa.add(producto);
      _bolsaCantidad = _productosBolsa.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeExplorador(
        onAddToBolsa: (producto) => _agregarABolsa(producto),
      ),
      BolsaScreen(productos: _productosBolsa),
      const Center(child: Text("Mensajes", style: TextStyle(fontSize: 22))),
       PerfilExplorador(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey[600],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_bag),
                if (_bolsaCantidad > 0)
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
                        '$_bolsaCantidad',
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
      ),
    );
  }
}
