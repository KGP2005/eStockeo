import 'package:estockeo_p1/Pages/Registro/registro_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) {
      setState(() => _emailError = 'Ingresa tu correo electrónico');
      return false;
    }
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email)) {
      setState(() => _emailError = 'Correo inválido');
      return false;
    }
    setState(() => _emailError = null);
    return true;
  }

  bool _validatePassword(String password) {
    if (password.isEmpty) {
      setState(() => _passwordError = 'Ingresa tu contraseña');
      return false;
    }
    if (password.length < 6) {
      setState(() => _passwordError = 'Mínimo 6 caracteres');
      return false;
    }
    setState(() => _passwordError = null);
    return true;
  }

  Future<void> _handleLogin() async {
    final email = _controller.emailController.text.trim();
    final password = _controller.passwordController.text;

    final emailValid = _validateEmail(email);
    final passwordValid = _validatePassword(password);

    if (emailValid && passwordValid) {
      await _controller.login(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // #FFFFFF
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Espaciado entre todo el contenido
              const SizedBox(height: 50), // Espaciado de logo
              _buildLogo(),
              const SizedBox(height: 35), // Espaciado de email field
              _buildEmailField(),
              const SizedBox(height: 20), // Espaciado de password field
              _buildPasswordField(),
              const SizedBox(height: 13), // Espaciado de remember password checkbox
              _buildRememberPasswordCheckbox(),
              const SizedBox(height: 21), // Espaciado de login button
              _buildLoginButton(),
              const SizedBox(height: 15), // Espaciado de forgot password link
              _buildForgotPasswordLink(), 
              const SizedBox(height: 15), // Espaciado de sign up row
              _buildSignUpRow(),
              const SizedBox(height: 21), // Espaciado de divider
              _buildDivider(),
              const SizedBox(height: 21), // Espaciado de social buttons
              _buildSocialButtons(),
              const SizedBox(height: 42), // Espaciado de bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_registro.png',
          height: 120,
          width: 120,
        ),
        const SizedBox(height: 5), // Espaciado entre logo y texto
        Text(
          'eStockeo',
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000), // #000000
            fontSize: 28, // Tamaño de letra
            fontWeight: FontWeight.w700, // Peso 700
            letterSpacing: 0.4, // Espaciado entre letras para mejor legibilidad
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 335, // Ancho de caja
          child: Container(
            height: 52, // Altura exacta de 52px
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF), // Fondo blanco
              borderRadius: BorderRadius.circular(12), // Bordes redondeados 12px
              border: Border.all(
                color: _emailError != null ? Colors.red : const Color(0xFFB8B8B8), // Borde gris claro #B8B8B8
                width: 1,
              ),
            ),
            child: TextField(
              controller: _controller.emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Color(0xFF000000)),
              onChanged: (value) {
                if (_emailError != null) _validateEmail(value);
              },
              decoration: const InputDecoration(
                hintText: 'Usuario',
                hintStyle: TextStyle(color: Color(0xFFB8B8B8)), // Placeholder gris claro #B8B8B8
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
              ),
            ),
          ),
        ),
        if (_emailError != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              _emailError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 335, // Ancho de caja
          child: Container(
            height: 52, // Altura exacta de 52px
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF), // Fondo blanco
              borderRadius: BorderRadius.circular(12), // Bordes redondeados 12px
              border: Border.all(
                color: _passwordError != null ? Colors.red : const Color(0xFFB8B8B8), // Borde gris claro #B8B8B8
                width: 1,
              ),
            ),
            child: TextField(
              controller: _controller.passwordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Color(0xFF000000)),
              onChanged: (value) {
                if (_passwordError != null) _validatePassword(value);
              },
              decoration: InputDecoration(
                hintText: 'Contraseña',
                hintStyle: const TextStyle(color: Color(0xFFB8B8B8)), // Placeholder gris claro #B8B8B8
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFFB8B8B8), // Ícono gris claro
                  ),
                  onPressed: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                ),
              ),
            ),
          ),
        ),
        if (_passwordError != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              _passwordError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildRememberPasswordCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() => _rememberMe = value ?? false);
          },
          activeColor: const Color(0xFF6E44FF), // Morado #6E44FF
          checkColor: Colors.white,
          side: const BorderSide(color: Color(0xFF000000)), // Borde negro
        ),
        Text(
          'Recordar contraseña',
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000), // Texto negro
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: 250, // Ancho de caja
      height: 52, // Altura exacta de 52px
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6E44FF), Color(0xFFBFADC9)], // Degradado morado a gris
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12), // Bordes redondeados 12px
        ),
        child: Container(
          margin: const EdgeInsets.all(2), // Margen para crear el efecto de borde degradado
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF), // Fondo blanco interior
            borderRadius: BorderRadius.circular(10), // Radio ligeramente menor
          ),
          child: ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Fondo transparente
              foregroundColor: const Color(0xFF000000), // Texto negro
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
              elevation: 0, // Sin sombra
            ),
            child: Text(
              'Iniciar sesión',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000), // Texto negro
                fontSize: 16,
                fontWeight: FontWeight.bold, // negrita
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          // TODO: Implementar recuperación de contraseña
        },
         child: Text(
          '¿Olvidaste tu contraseña?',
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000), // Texto negro
            fontSize: 14,
            fontWeight: FontWeight.bold, // En negrita
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿No tienes cuenta? ',
            style: GoogleFonts.poppins(
              color: const Color(0xFF000000), // Texto negro
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistroPage(),
                ),
              );
            },
            child: Text(
              'Regístrate',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000), // Texto negro
                fontSize: 17,
                fontWeight: FontWeight.bold, // En negrita
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100, // Línea izquierda de 100px (15% más corta)
          height: 1,
          color: const Color(0xFFEDECF3), // Líneas finas color gris claro #EDECF3
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Aumentado de 16 a 20px
          child: Text(
            'O',
            style: GoogleFonts.poppins(
              color: const Color(0xFFEDECF3), // Color gris clarorgb(22, 22, 22)
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: 100, // Línea derecha de 100px (15% más corta)
          height: 1,
          color: const Color(0xFFEDECF3), // Líneas finas color gris claro #EDECF3
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(FontAwesomeIcons.google, 'G'),
        const SizedBox(width: 50), // Espaciado fijo de 16px entre botones
        _buildSocialButton(Icons.facebook, 'f'),
        const SizedBox(width: 50), // Espaciado fijo de 16px entre botones
        _buildSocialButton(Icons.apple, '🍎'),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String text) {
    return SizedBox(
      width: 52, // Forzar ancho exacto de 52px
      height: 52, // Forzar alto exacto de 52px
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6E44FF), Color(0xFFBFADC9)], // Degradado morado a gris
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12), // Radio 12px
        ),
        child: Container(
          margin: const EdgeInsets.all(1.5), // Margen para crear el efecto de borde degradado
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF), // Fondo blanco interior
            borderRadius: BorderRadius.circular(10.5), // Radio ligeramente menor
          ),
          child: Center(
            child: text == 'G' 
              ? Text(
                  'G',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF000000), // Íconos negros
                    fontSize: 35, // Reducido para mejor proporción
                    fontWeight: FontWeight.bold,
                  ),
                )
              : text == 'f'
                ? Text(
                    'f',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF000000), // Íconos negros
                      fontSize: 35, // Reducido para mejor proporción
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Icon(
                    icon,
                    color: const Color(0xFF000000), // Íconos negros
                    size: 35, // Reducido para mejor proporción
                  ),
          ),
        ),
      ),
    );
  }
}