import 'package:flutter/material.dart';
import '../Carrito/carrito_controller.dart';

class HomeExploradorController extends ChangeNotifier {
  final carritoController = CarritoController()
    ..productos = [
      {
        'title': 'Zapatillas Nike Air Max',
        'image': 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,q_auto:eco/0b7e2e2e-2e6e-4e7e-9e7e-2e6e4e7e9e7e/air-max-90-shoes.png',
        'price': 399.99,
        'oldPrice': 499.99,
        'discount': '20% OFF',
        'size': '42',
        'color': 'Negro',
        'cantidad': 1,
      },
      {
        'title': 'Polera Adidas Originals',
        'image': 'https://assets.adidas.com/images/w_600,f_auto,q_auto/1e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e_9366/Originals_Hoodie.png',
        'price': 199.99,
        'oldPrice': 249.99,
        'discount': '20% OFF',
        'size': 'M',
        'color': 'Azul',
        'cantidad': 2,
      },
      {
        'title': 'Gorra Puma Sport',
        'image': 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa/global/022416/01/fnd/PNA/w/1000/h/1000/fmt/png',
        'price': 59.99,
        'oldPrice': 79.99,
        'discount': '25% OFF',
        'size': 'Única',
        'color': 'Rojo',
        'cantidad': 1,
      },
    ];
  int currentIndex = 0;
  int bolsaCantidad = 0;
  List<Map<String, dynamic>> productosBolsa = [];

  void agregarABolsa(Map<String, dynamic> producto) {
    productosBolsa.add(producto);
    bolsaCantidad = productosBolsa.length;
    notifyListeners();
  }

  void cambiarPagina(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
