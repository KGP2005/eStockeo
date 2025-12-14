import 'package:flutter/material.dart';
import '../../componentes/nav_bar.dart';
import '../Carrito/carrito_page.dart';
import '../MensajesExplorador/MensajesExplorador_page.dart';
import '../PerfilExporador/PerfilExplorador_page.dart';
import 'home_explorador_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:typed_data';
class HomeExplorador extends StatefulWidget {
  const HomeExplorador({Key? key}) : super(key: key);

  @override
  State<HomeExplorador> createState() => _HomeExploradorState();
}

class _HomeExploradorState extends State<HomeExplorador> {
  final HomeExploradorController _controller = HomeExploradorController();
  final PageController _pageController = PageController();
  bool _mostrarCompra = false;
  // Estado para el panel de compra
  int _selectedColorIndex = 0;
  String _selectedSize = 'M';
  int _cantidad = 1;
  final List<Color> _availableColors = [Colors.white, Colors.black, Color(0xFF6B8E23)];
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

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
        ColorFiltered(
          colorFilter: _mostrarCompra ? ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken) : ColorFilter.mode(Colors.transparent, BlendMode.darken),
          child: Image.network(
            post["image"],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error, size: 50),
              );
            },
          ),
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
    final String brand = (post['brand'] ?? '').toString();
    final String title = (post['title'] ?? '').toString();
    final String initials = brand.length >= 2 ? brand.substring(0, 2).toUpperCase() : brand.toUpperCase();

    return Stack(
      children: [
        // Barra inferior con título, marca y botón comprar a la derecha
        Positioned(
          bottom: 30,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo circular con iniciales
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              initials,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            brand,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '128 unidades disponibles',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.more_horiz, color: Colors.white70, size: 18),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Botón Comprar alineado a la derecha (pill)
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6E44FF), Color(0xFF9C88FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _mostrarCompra = true;
                    });
                  },
                  label: Text(
                    'Comprar',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Botones de interacción (derecha) -- se mantienen
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _IconCounter(
                iconPath: 'assets/icons/heart white.png',
                count: 4345,
              ),
              const SizedBox(height: 20),
              _IconCounter(
                iconPath: 'assets/icons/reseñas.png',
                count: 10,
              ),
              const SizedBox(height: 20),
              _IconCounter(
                iconPath: 'assets/icons/etiqueta.png',
                count: 1533,
              ),
              const SizedBox(height: 20),
              _IconCounter(
                iconPath: 'assets/icons/compartir.png',
                count: 520,
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _IconCounter({
    required String iconPath,
    required int count,
  }) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 28,
          height: 28,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 6),
        Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
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
    final double price = (post['price'] ?? 0).toDouble();
    final double? originalPrice = post.containsKey('original_price') ? (post['original_price'] as num).toDouble() : null;
    final int discountPercent = (originalPrice != null && originalPrice > price)
        ? (((originalPrice - price) / originalPrice) * 100).round()
        : 0;

    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: GestureDetector(
        onTap: () {}, // Evitar que se cierre al tocar el contenedor
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    post['title'] ?? '',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post['brand'] ?? '',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Precio / descuento / rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'S/ ${price.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (originalPrice != null) ...[
                        Text(
                          'S/ ${originalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$discountPercent% DESCUENTO',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFC857),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFFC857), size: 14),
                            const SizedBox(width: 8),
                            Text('4.1', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 12),

                  // Color y cantidad
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Color:', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                            const SizedBox(height: 8),
                            Row(
                              children: List.generate(_availableColors.length, (i) {
                                final color = _availableColors[i];
                                final selected = i == _selectedColorIndex;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedColorIndex = i),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: selected ? Border.all(color: Colors.white, width: 2) : null,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      // Cantidad
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Cantidad', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() { if (_cantidad > 1) _cantidad--; }),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.remove, color: Colors.white, size: 18),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 36,
                                alignment: Alignment.center,
                                child: Text('$_cantidad', style: GoogleFonts.poppins(color: Colors.white)),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => setState(() { _cantidad++; }),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Tallaje
                  Text('Talla', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: _sizes.map((s) {
                      final selected = s == _selectedSize;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = s),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected ? Colors.white12 : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(s, style: GoogleFonts.poppins(color: Colors.white)),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 12),
                  Text('${post['stock'] ?? 56} unidades disponibles', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Guía de tallas >', style: GoogleFonts.poppins(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Botón añadir a la bolsa
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF6E44FF), Color(0xFF9C88FF)]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Añadir al carrito: puedes ampliar post con selección
                          final item = Map<String, dynamic>.from(post);
                          item['cantidad'] = _cantidad;
                          item['color'] = _availableColors[_selectedColorIndex].value;
                          item['talla'] = _selectedSize;
                          _controller.agregarABolsa(item);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${post['title']} agregado a la bolsa'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          setState(() { _mostrarCompra = false; });
                        },
                        icon: const Icon(Icons.shopping_bag, color: Colors.white),
                        label: Text('Añadir a la bolsa', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      
      
    ); // ← Este es el único cierre necesario
  }
}