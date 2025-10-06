import 'package:flutter/material.dart';

class CarritoController extends ChangeNotifier {
  final List<Map<String, dynamic>> _productos = [];

  List<Map<String, dynamic>> get productos => _productos;

  int get cantidadTotal {
    int total = 0;
    for (var producto in _productos) {
      total += (producto['cantidad'] ?? 1) as int;
    }
    return total;
  }

  double get precioProductos {
    double total = 0;
    for (var producto in _productos) {
      final precio = (producto['price'] ?? 0.0) as num;
      final cantidad = (producto['cantidad'] ?? 1) as int;
      total += precio.toDouble() * cantidad;
    }
    return total;
  }

  double get envio {
    // Envío gratis si el total supera cierto monto
    return precioProductos > 100 ? 0.0 : 10.0;
  }

  double get subtotal {
    return precioProductos;
  }

  void agregarProducto(Map<String, dynamic> producto) {
    // Verificar si ya existe el producto
    final index = _productos.indexWhere(
      (p) =>
          p['title'] == producto['title'] &&
          p['size'] == producto['size'] &&
          p['color'] == producto['color'],
    );

    if (index >= 0) {
      // Si existe, incrementar cantidad
      _productos[index]['cantidad'] = (_productos[index]['cantidad'] ?? 1) + 1;
    } else {
      // Si no existe, agregar nuevo
      final nuevoProducto = Map<String, dynamic>.from(producto);
      nuevoProducto['cantidad'] = 1;
      nuevoProducto['seleccionado'] = true; // Por defecto seleccionado
      _productos.add(nuevoProducto);
    }
    notifyListeners();
  }

  void eliminarProducto(int index) {
    if (index >= 0 && index < _productos.length) {
      _productos.removeAt(index);
      notifyListeners();
    }
  }

  void actualizarCantidad(int index, int nuevaCantidad) {
    if (index >= 0 && index < _productos.length) {
      if (nuevaCantidad <= 0) {
        eliminarProducto(index);
      } else {
        _productos[index]['cantidad'] = nuevaCantidad;
        notifyListeners();
      }
    }
  }

  void toggleSeleccion(int index) {
    if (index >= 0 && index < _productos.length) {
      _productos[index]['seleccionado'] =
          !(_productos[index]['seleccionado'] ?? true);
      notifyListeners();
    }
  }

  void vaciarCarrito() {
    _productos.clear();
    notifyListeners();
  }

  List<Map<String, dynamic>> get productosSeleccionados {
    return _productos
        .where((producto) => producto['seleccionado'] == true)
        .toList();
  }

  double get totalSeleccionado {
    double total = 0;
    for (var producto in productosSeleccionados) {
      final precio = (producto['price'] ?? 0.0) as num;
      final cantidad = (producto['cantidad'] ?? 1) as int;
      total += precio.toDouble() * cantidad;
    }
    return total;
  }
}