import 'package:flutter/material.dart';

class HomeExplorador extends StatefulWidget {
  final VoidCallback onAddToBolsa;

  const HomeExplorador({super.key, required this.onAddToBolsa});

  @override
  _HomeExploradorState createState() => _HomeExploradorState();
}

class _HomeExploradorState extends State<HomeExplorador> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _mostrarCompra = false;

  final List<Map<String, dynamic>> _posts = [
    {
      "image": "https://picsum.photos/500/800?1",
      "title": "Blusa de lino oversize",
      "brand": "ARINZA",
      "price": 120.0,
      "likes": 4345,
      "comments": 76,
      "shares": 1533,
    },
    {
      "image": "https://picsum.photos/500/800?2",
      "title": "Vestido casual verano",
      "brand": "MAGNIFICA",
      "price": 95.0,
      "likes": 2310,
      "comments": 45,
      "shares": 800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (_mostrarCompra) {
            setState(() {
              _mostrarCompra = false;
            });
          }
        },
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _posts.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
              _mostrarCompra = false; // al cambiar de post, se cierra vista compra
            });
          },
          itemBuilder: (context, index) {
            final post = _posts[index];

            return Stack(
              fit: StackFit.expand,
              children: [
                // Imagen de fondo
                Image.network(post["image"], fit: BoxFit.cover),

                // Degradado inferior
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),

                // 🔹 Vista normal
                if (!_mostrarCompra) ...[
                  Positioned(
                    bottom: 80,
                    left: 16,
                    right: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post["title"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(post["brand"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_bag, color: Colors.white),
                          label: const Text("Comprar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarCompra = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 100,
                    child: Column(
                      children: [
                        const Icon(Icons.favorite, color: Colors.white, size: 32),
                        Text("${post["likes"]}",
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 16),
                        const Icon(Icons.comment, color: Colors.white, size: 32),
                        Text("${post["comments"]}",
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 16),
                        const Icon(Icons.share, color: Colors.white, size: 32),
                        Text("${post["shares"]}",
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],

                // 🔹 Vista de compra
                if (_mostrarCompra)
                  Positioned(
                    bottom: 120,
                    left: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {}, // evita que tocar dentro cierre la vista
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post["title"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(post["brand"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Text("Precio: S/ ${post["price"]}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              widget.onAddToBolsa();
                              setState(() {
                                _mostrarCompra = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Enviar a bolsa",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
