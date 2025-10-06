import 'package:estockeo_p1/Pages/Registro/registro_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.0 : screenWidth * 0.25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 48),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 16),
              _buildOptionsRow(),
              const SizedBox(height: 24),
              _buildLoginButton(),
              const SizedBox(height: 24),
              _buildSignUpRow(),
              const SizedBox(height: 16),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSocialButtons(),
              const SizedBox(height: 48),
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
        const SizedBox(height: 24),
        const Text(
          'eStockeo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _emailError != null ? Colors.red : Colors.grey.shade400,
            ),
          ),
          child: TextField(
            controller: _controller.emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              if (_emailError != null) _validateEmail(value);
            },
            decoration: const InputDecoration(
              hintText: 'Correo electrónico',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _passwordError != null ? Colors.red : Colors.grey.shade400,
            ),
          ),
          child: TextField(
            controller: _controller.passwordController,
            obscureText: !_isPasswordVisible,
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              if (_passwordError != null) _validatePassword(value);
            },
            decoration: InputDecoration(
              hintText: 'Contraseña',
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                },
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

  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() => _rememberMe = value ?? false);
              },
              activeColor: const Color(0xFF673AB7),
              checkColor: Colors.white,
              side: const BorderSide(color: Colors.grey),
            ),
            const Text(
              'Mantener conectado',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: Implementar recuperación de contraseña
          },
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(color: Color(0xFF673AB7)),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF673AB7),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Ingresar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '¿No tienes cuenta? ',
          style: TextStyle(color: Colors.black),
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
          child: const Text(
            'Regístrate',
            style: TextStyle(color: Color(0xFF673AB7)),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'O conéctate con',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(FontAwesomeIcons.google),
        _buildSocialButton(Icons.facebook, size: 36),
        _buildSocialButton(Icons.apple, size: 36),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, {double size = 30}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Icon(icon, color: Colors.black, size: size),
    );
  }
}