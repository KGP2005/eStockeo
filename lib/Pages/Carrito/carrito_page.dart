import 'package:flutter/material.dart';
import 'carrito_controller.dart';

class CarritoPage extends StatefulWidget {
  final CarritoController? controller;

  const CarritoPage({Key? key, this.controller}) : super(key: key);

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  late CarritoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CarritoController();
    
    // Datos de prueba (eliminar cuando uses datos reales)
    if (_controller.productos.isEmpty) {
      _agregarProductosPrueba();
    }
  }

  void _agregarProductosPrueba() {
    _controller.agregarProducto({
      'title': 'Conjunto Deportivo',
      'image': 'https://picsum.photos/200/300?1',
      'price': 59.99,
      'oldPrice': 79.99,
      'discount': '25% OFF',
      'size': 'L',
      'color': 'Crema',
    });
    
    _controller.agregarProducto({
      'title': 'Suéter de Cuello Alto',
      'image': 'https://picsum.photos/200/300?2',
      'price': 39.99,
      'oldPrice': 49.99,
      'discount': '20% OFF',
      'size': 'M',
      'color': 'Blanco',
    });
    
    _controller.agregarProducto({
      'title': 'Camiseta de Algodón',
      'image': 'https://picsum.photos/200/300?3',
      'price': 30.00,
      'oldPrice': 39.99,
      'discount': '25% OFF',
      'size': 'L',
      'color': 'Negro',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bolsa de Compras',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.productos.isEmpty) {
            return _buildEmptyCart();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _controller.productos.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(index);
                  },
                ),
              ),
              _buildResumenCompra(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Tu bolsa está vacía',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega productos para comenzar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final producto = _controller.productos[index];
    final seleccionado = producto['seleccionado'] ?? true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                producto['image'] ?? '',
                width: 100,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 40),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),

            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          producto['title'] ?? 'Producto',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Checkbox de selección
                      Checkbox(
                        value: seleccionado,
                        onChanged: (value) {
                          _controller.toggleSeleccion(index);
                        },
                        activeColor: const Color(0xFF673AB7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Precio
                  Row(
                    children: [
                      Text(
                        'S/ ${producto['price']?.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (producto['discount'] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            producto['discount'],
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  // Precio anterior tachado
                  if (producto['oldPrice'] != null)
                    Text(
                      'Antes: S/ ${producto['oldPrice']?.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(height: 8),

                  // Talla y color
                  Row(
                    children: [
                      if (producto['size'] != null) ...[
                        Text(
                          'Talla: ${producto['size']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('|', style: TextStyle(color: Colors.grey[400])),
                        const SizedBox(width: 4),
                      ],
                      if (producto['color'] != null)
                        Text(
                          'Color: ${producto['color']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Controles de cantidad
                  Row(
                    children: [
                      _buildQuantityButton(
                        Icons.remove,
                        () {
                          final cantidad = producto['cantidad'] ?? 1;
                          _controller.actualizarCantidad(index, cantidad - 1);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${producto['cantidad'] ?? 1}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildQuantityButton(
                        Icons.add,
                        () {
                          final cantidad = producto['cantidad'] ?? 1;
                          _controller.actualizarCantidad(index, cantidad + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildResumenCompra() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildResumenFila(
            'Precio de productos',
            'S/${_controller.totalSeleccionado.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildResumenFila(
            'Envío',
            _controller.envio == 0 ? 'Envío gratis' : 'S/${_controller.envio.toStringAsFixed(2)}',
            esEnvio: true,
          ),
          const Divider(height: 24),
          _buildResumenFila(
            'Subtotal',
            'S/${(_controller.totalSeleccionado + _controller.envio).toStringAsFixed(2)}',
            esTotal: true,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _controller.productosSeleccionados.isEmpty
                  ? null
                  : () {
                      // TODO: Implementar proceso de pago
                      _mostrarConfirmacion();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF673AB7),
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Confirmar y pagar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumenFila(String label, String valor, {bool esTotal = false, bool esEnvio = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: esTotal ? 16 : 14,
            fontWeight: esTotal ? FontWeight.bold : FontWeight.normal,
            color: esTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          valor,
          style: TextStyle(
            fontSize: esTotal ? 20 : 14,
            fontWeight: esTotal ? FontWeight.bold : FontWeight.w600,
            color: esEnvio && _controller.envio == 0
                ? Colors.green
                : (esTotal ? Colors.black : Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  void _mostrarConfirmacion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Compra'),
        content: Text(
          '¿Deseas confirmar la compra de ${_controller.productosSeleccionados.length} producto(s) por un total de S/${(_controller.totalSeleccionado + _controller.envio).toStringAsFixed(2)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Procesar pago
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pedido confirmado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF673AB7),
            ),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}