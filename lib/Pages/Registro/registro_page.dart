import 'package:flutter/material.dart';
import 'registro_controller.dart';
import 'steps/paso1_correo.dart';
import 'steps/paso2_correo.dart';
import 'steps/paso3_correo.dart';
import 'steps/paso4_correo.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final RegistroController _controller = RegistroController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Escuchar cambios del controlador para sincronizar el PageView
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _controller.pasoActual,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // Mostrar botón de retroceso solo si no estamos en el paso 1
            if (_controller.pasoActual > 0) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  _controller.pasoAnterior();
                },
              );
            }
            // En el paso 1, botón para salir
            return IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Text(
              'Paso ${_controller.pasoActual + 1}/4',
              style: const TextStyle(
                color: Color(0xFF5D4FB5),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Deshabilitar swipe
        children: [
          Paso1Correo(controller: _controller),
          Paso2Datos(controller: _controller),
          Paso3Contrasena(controller: _controller),
          Paso4Politicas(controller: _controller),
        ],
      ),
    );
  }
}