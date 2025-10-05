import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class BolsaScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productos;

  const BolsaScreen({Key? key, required this.productos}) : super(key: key);

  double get subtotal {
    double s = 0.0;
    for (final p in productos) {
      final price = p['price'];
      if (price is num) {
        s += price.toDouble();
      } else if (price is String) {
        // intenta parsear cadenas como "S/ 39.99" o "39.99"
        final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
        s += double.tryParse(cleaned) ?? 0.0;
      }
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Bolsa de Compras",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: productos.isEmpty
                  ? const Center(child: Text("La bolsa está vacía"))
                  : ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final p = productos[index];
                        return _buildCartItem(
                          p['title'] ?? 'Sin título',
                          'S/ ${p['price'].toString()}',
                          p['brand'] ?? '',
                          p['image'] ?? '',
                          true,
                        );
                      },
                    ),
            ),
            const Divider(),
            _buildSummary(),
            const SizedBox(height: 16),

            // Confirmar con fondo degradado (mantuve tu estilo)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6A5AE0), Color(0xFFB58DF1)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {

                  },
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
    String title,
    String price,
    String details,
    String imageUrl,
    bool selected,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imageUrl.isNotEmpty
              ? Image.network(imageUrl, width: 60, fit: BoxFit.cover)
              : Container(width: 60, height: 60, color: Colors.grey[200]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(details, style: const TextStyle(fontSize: 12)),
          ],
        ),
        // Si quieres luego editar cantidad por producto, reemplaza el trailing por controles dinámicos
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? Icons.check_box : Icons.check_box_outline_blank,
              color: selected ? Colors.deepPurple : Colors.grey,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    // Implementar disminución de cantidad por producto
                  },
                  iconSize: 20,
                ),
                const Text("1"),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    // Implementar aumento de cantidad por producto
                  },
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      children: [
        _SummaryRow(label: "Precio de productos", value: "S/ ${subtotal.toStringAsFixed(2)}"),
        const _SummaryRow(label: "Envío", value: "Envío gratis"),
        const Divider(),
        _SummaryRow(label: "Subtotal", value: "S/ ${subtotal.toStringAsFixed(2)}", isBold: true),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class BolsaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bolsa")),
      body: Center(child: Text("Tu carrito está vacío")),
    );
  }
}
*/