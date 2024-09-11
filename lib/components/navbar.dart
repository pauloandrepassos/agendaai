import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/login_page.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red, // Ajuste a cor conforme necessário
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo do sistema
          Image.asset(
            'assets/logo-agendaai.png', // Caminho para a logo
            height: 40,
          ),
          // Ícone de Logout
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Função de Logout
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token'); // Remove o token do cache

              // Redireciona para a página de login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
