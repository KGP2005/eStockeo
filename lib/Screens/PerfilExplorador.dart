import 'package:flutter/material.dart';

class PerfilExplorador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
            SizedBox(height: 12),
            Text(
              "Usuario Explorador",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text("usuario@correo.com"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Editar perfil")),
          ],
        ),
      ),
    );
  }
}
