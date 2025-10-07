import 'package:flutter/material.dart';
import '../../componentes/interaction_icons.dart';
import '../../componentes/nav_bar.dart';

class HomeWithInteractions extends StatefulWidget {
  const HomeWithInteractions({super.key});

  @override
  State<HomeWithInteractions> createState() => _HomeWithInteractionsState();
}

class _HomeWithInteractionsState extends State<HomeWithInteractions> {
  int _currentIndex = 0;
  int _likes = 76;
  int _comments = 23;
  int _shares = 1533;
  bool _isLiked = false;
  bool _isTagged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay oscuro
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                // Header con información del producto
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Blusa de lino oversize',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'ARINZA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Botón de compra
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6E44FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/shopping-bag-02.png',
                              width: 16,
                              height: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Comprar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Sección de reseñas
                const ReviewSection(
                  productName: 'Blusa de lino oversize',
                  brandName: 'ARINZA',
                  rating: 4.5,
                  reviewCount: 128,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Iconos de interacción (lado derecho)
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: InteractionIcons(
                likes: _likes,
                comments: _comments,
                shares: _shares,
                isLiked: _isLiked,
                isTagged: _isTagged,
                onLike: () {
                  setState(() {
                    if (_isLiked) {
                      _likes--;
                    } else {
                      _likes++;
                    }
                    _isLiked = !_isLiked;
                  });
                },
                onTag: () {
                  setState(() {
                    _isTagged = !_isTagged;
                  });
                },
                onComment: () {
                  // TODO: Implementar navegación a comentarios
                },
                onShare: () {
                  // TODO: Implementar funcionalidad de compartir
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        bolsaCantidad: 3,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
