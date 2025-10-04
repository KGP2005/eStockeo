import 'package:flutter/material.dart';
import '../Home_Explorador/HomeExplorador_page.dart';
import '../Carrito/carrito_page.dart';
import '../PerfilExporador/PerfilExplorador_page.dart';
class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

// AQUI PON EL NOMBRE DE LA CLASE DE LA SCREEN QUE LO LLAMARA AL SELECCIONAR EL BOTON
class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeExplorador(),
    BolsaScreen(),
     Center(child: Text("Mensajes", style: TextStyle(fontSize: 22))),
    PerfilExplorador(),
  ];

  @override
  Widget build(BuildContext context) {
    //ESTO ES PARA CAMBIAR PARAMETROS DE LA BARRA INFERIOR
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
        //ESTO SON LAS SELECCIONES
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Bolsa',
          ),
        BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
