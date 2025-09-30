import 'package:flutter/material.dart';

class BolsaScreen extends StatelessWidget {
  const BolsaScreen({super.key});

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
              child: ListView(
                children: [
                  _buildCartItem(
                    "Conjunto Deportivo",
                    "S/ 39.99",
                    "Talla: L  |  Color: Crema",
                    "https://i.imgur.com/0y8Ftya.png",
                    true,
                  ),
                  _buildCartItem(
                    "Suéter de Cuello Alto",
                    "S/ 39.99",
                    "Talla: M  |  Color: Blanco",
                    "https://i.imgur.com/0y8Ftya.png",
                    false,
                  ),
                  _buildCartItem(
                    "Camiseta de Algodón",
                    "S/ 30.00",
                    "Talla: L  |  Color: Negro",
                    "https://i.imgur.com/0y8Ftya.png",
                    true,
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildSummary(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const LinearGradient(
                            colors: [Color(0xFF6A5AE0), Color(0xFFB58DF1)],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70))
                          as Color?, // workaround gradiente
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Confirmar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(imageUrl, width: 60, fit: BoxFit.cover),
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
                  onPressed: () {},
                  iconSize: 20,
                ),
                const Text("1"),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {},
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
      children: const [
        _SummaryRow(label: "Precio de productos", value: "S/110"),
        _SummaryRow(label: "Envío", value: "Envío gratis"),
        Divider(),
        _SummaryRow(label: "Subtotal", value: "S/110", isBold: true),
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
    super.key,
  });

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