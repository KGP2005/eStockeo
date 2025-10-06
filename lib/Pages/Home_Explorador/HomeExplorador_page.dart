import 'package:flutter/material.dart';
import '../../componentes/nav_bar.dart';
import '../Carrito/carrito_page.dart';
import '../Carrito/carrito_controller.dart';
import '../MensajesExplorador/MensajesExplorador_page.dart';
import '../PerfilExporador/PerfilExplorador_page.dart';
import 'home_explorador_controller.dart';

class HomeExplorador extends StatefulWidget {
  const HomeExplorador({Key? key}) : super(key: key);

  @override
  State<HomeExplorador> createState() => _HomeExploradorState();
}

class _HomeExploradorState extends State<HomeExplorador> {
  final HomeExploradorController _controller = HomeExploradorController();
  final PageController _pageController = PageController();
  bool _mostrarCompra = false;

  // Posts de ejemplo (después los cargarás de la BD)
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
    {
      "image": "https://picsum.photos/500/800?3",
      "title": "Pantalón cargo",
      "brand": "BOUTIQUE",
      "price": 150.0,
      "likes": 5120,
      "comments": 92,
      "shares": 2100,
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return _buildCurrentPage();
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return NavBar(
            currentIndex: _controller.currentIndex,
            bolsaCantidad: _controller.bolsaCantidad,
            onTap: (index) {
              _controller.cambiarPagina(index);
            },
          );
        },
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_controller.currentIndex) {
      case 0:
        return _buildFeed();
      case 1:
        return CarritoPage(controller: _controller.carritoController);
      case 2:
        return const MensajesExplorador();
      case 3:
        return PerfilExplorador();
      default:
        return _buildFeed();
    }
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
          return _buildPost(post);
        },
      ),
    );
  }

  Widget _buildPost(Map<String, dynamic> post) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        Image.network(
          post["image"],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error, size: 50),
            );
          },
        ),

        // Gradiente oscuro
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.0, 0.3, 1.0],
            ),
          ),
        ),

        // Contenido según estado
        if (!_mostrarCompra)
          _buildNormalView(post)
        else
          _buildCompraView(post),
      ],
    );
  }

  Widget _buildNormalView(Map<String, dynamic> post) {
    return Stack(
      children: [
        // Información del producto (abajo izquierda)
        Positioned(
          bottom: 80,
          left: 16,
          right: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post["title"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                post["brand"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_bag, color: Colors.white),
                label: const Text(
                  "Comprar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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

        // Botones de interacción (derecha)
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              _buildInteractionButton(
                Icons.favorite_border,
                "${post["likes"]}",
                () {
                  // TODO: Implementar like
                  print("Like presionado");
                },
              ),
              const SizedBox(height: 20),
              _buildInteractionButton(
                Icons.comment,
                "${post["comments"]}",
                () {
                  // TODO: Implementar comentarios
                  print("Comentarios presionado");
                },
              ),
              const SizedBox(height: 20),
              _buildInteractionButton(
                Icons.share,
                "${post["shares"]}",
                () {
                  // TODO: Implementar compartir
                  print("Compartir presionado");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionButton(
    IconData icon,
    String count,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32,
            shadows: const [
              Shadow(
                color: Colors.black54,
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompraView(Map<String, dynamic> post) {
    return Positioned(
      bottom: 100,
      left: 16,
      right: 16,
      child: GestureDetector(
        onTap: () {}, // Evitar que se cierre al tocar el contenedor
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                post["title"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post["brand"],
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "S/ ${post["price"].toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Agregar al carrito
                    _controller.agregarABolsa(post);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${post["title"]} agregado al carrito'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    
                    setState(() {
                      _mostrarCompra = false;
                    });
                  },
                  icon: const Icon(Icons.shopping_bag, color: Colors.white),
                  label: const Text(
                    "Agregar al carrito",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}