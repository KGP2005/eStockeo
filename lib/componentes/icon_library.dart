import 'package:flutter/material.dart';

class IconLibrary extends StatelessWidget {
  const IconLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1123),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),
                  // fila principal de íconos
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 34,
                    runSpacing: 34,
                    children: [
                      Image.asset('assets/icons/heart.png', width: 61, height: 55),
                      Image.asset('assets/icons/tag.png', width: 61, height: 58),
                      Image.asset('assets/icons/user.png', width: 46, height: 18),
                      Image.asset('assets/icons/notification.png', width: 61, height: 61),
                      Image.asset('assets/icons/package.png', width: 61, height: 61),
                      Image.asset('assets/icons/arrow.png', width: 46, height: 33),
                      Image.asset('assets/icons/home.png', width: 61, height: 61),
                      Image.asset('assets/icons/search.png', width: 54, height: 54),
                      Image.asset('assets/icons/bag.png', width: 61, height: 61),
                      Image.asset('assets/icons/settings.png', width: 54, height: 54),
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
}
