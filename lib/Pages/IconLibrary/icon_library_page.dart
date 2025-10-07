import 'package:flutter/material.dart';

class IconLibraryPage extends StatelessWidget {
  const IconLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1123),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1123),
        title: const Text(
          'Librería de Iconos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // fila principal de íconos
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 34,
                    runSpacing: 34,
                    children: [
                      _buildIconCard('assets/icons/heart.png', 'Heart', 61, 55),
                      _buildIconCard('assets/icons/tag.png', 'Tag', 61, 58),
                      _buildIconCard('assets/icons/user.png', 'User', 46, 18),
                      _buildIconCard('assets/icons/notification.png', 'Notification', 61, 61),
                      _buildIconCard('assets/icons/package.png', 'Package', 61, 61),
                      _buildIconCard('assets/icons/arrow.png', 'Arrow', 46, 33),
                      _buildIconCard('assets/icons/home.png', 'Home', 61, 61),
                      _buildIconCard('assets/icons/search.png', 'Search', 54, 54),
                      _buildIconCard('assets/icons/bag.png', 'Bag', 61, 61),
                      _buildIconCard('assets/icons/settings.png', 'Settings', 54, 54),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF625FDA),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard(String assetPath, String name, double width, double height) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F3A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF625FDA).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetPath,
            width: width,
            height: height,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
