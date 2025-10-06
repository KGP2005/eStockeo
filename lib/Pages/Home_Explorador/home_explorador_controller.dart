import 'package:flutter/material.dart';
import '../Carrito/carrito_controller.dart';

class HomeExploradorController extends ChangeNotifier {
  final CarritoController carritoController = CarritoController();
  int _currentIndex = 0;

  HomeExploradorController() {
    // Escuchar cambios del carrito para actualizar el badge
    carritoController.addListener(_onCarritoChanged);
  }

  void _onCarritoChanged() {
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
  int get bolsaCantidad => carritoController.cantidadTotal;

  void cambiarPagina(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void agregarABolsa(Map<String, dynamic> producto) {
    carritoController.agregarProducto(producto);
    notifyListeners();
  }

  @override
  void dispose() {
    carritoController.removeListener(_onCarritoChanged);
    carritoController.dispose();
    super.dispose();
  }
}