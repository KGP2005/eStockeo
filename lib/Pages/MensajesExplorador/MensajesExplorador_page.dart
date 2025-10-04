import 'package:flutter/material.dart';

class MensajesExplorador extends StatelessWidget {
  const MensajesExplorador({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {"name": "ARINZA", "msg": "Gracias por la atención", "avatar": "A"},
      {"name": "MAGNIFICA", "msg": "Compartió un video hace 2h", "avatar": "M"},
      {
        "name": "BOUTIQUE",
        "msg": "Hola, que color de prendas tiene",
        "avatar": "B",
      },
      {"name": "FASHION", "msg": "Activo/a ahora", "avatar": "F"},
      {"name": "FASHION", "msg": "Compartió un video hace 2h", "avatar": "F"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mensajería",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Botón "Mis pedidos"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Center(
                child: Text(
                  "🛍 Mis pedidos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Notificación "Actividad"
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange.shade200,
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
            title: const Text(
              "Actividad",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            subtitle: const Text(
              "El producto de tu lista de deseos bajo un 50% de descuento",
            ),
          ),
          const Divider(),

          // Lista de chats
          Expanded(
            child: ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      chat["avatar"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    chat["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chat["msg"]!),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
