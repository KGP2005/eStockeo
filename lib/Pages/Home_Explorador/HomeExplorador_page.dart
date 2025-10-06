import 'package:flutter/material.dart';
import '../../componentes/nav_bar.dart';
import '../Carrito/carrito_page.dart';
import 'home_explorador_controller.dart';
import '../PerfilExporador/PerfilExplorador_page.dart';

class HomeExplorador extends StatefulWidget {
  final void Function(Map<String, dynamic>) onAddToBolsa;
  const HomeExplorador({Key? key, required this.onAddToBolsa}) : super(key: key);

  @override
  State<HomeExplorador> createState() => _HomeExploradorState();
}

class _HomeExploradorState extends State<HomeExplorador> {
  final HomeExploradorController _controller = HomeExploradorController();
  final PageController _pageController = PageController();
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
    // El controlador decide qué página mostrar
    Widget currentPage;
    switch (_controller.currentIndex) {
      case 0:
        currentPage = _buildFeed();
        break;
      case 1:
        currentPage = CarritoPage(controller: _controller.carritoController);
        break;
      case 2:
        currentPage = const Center(child: Text("Mensajes", style: TextStyle(fontSize: 22)));
        break;
      case 3:
        currentPage = PerfilExplorador();
        break;
      default:
        currentPage = _buildFeed();
    }
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: NavBar(
        currentIndex: _controller.currentIndex,
        bolsaCantidad: _controller.bolsaCantidad,
        onTap: (index) {
          setState(() {
            _controller.cambiarPagina(index);
          });
        },
      ),
    );
  }

  Widget _buildFeed() {
    return GestureDetector(
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
            _mostrarCompra = false;
          });
        },
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(post["image"], fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
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
              if (_mostrarCompra)
                Positioned(
                  bottom: 120,
                  left: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {},
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
                          onPressed: null,
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
    );
  }
}
