import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/app_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool showLogout; // Controle do ícone de logout

  CustomAppBar({
    required this.title,
    this.height = 60.0,
    this.showLogout = true, // Valor padrão como true para mostrar o logout
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        title: Image.asset('assets/logo-agendaai.png', height: height),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFA680F), // #FA680F
                Color(0xFFFA240F), // #FA240F
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
          ),
        ),
        backgroundColor:
            Colors.transparent, // Transparente para mostrar o gradiente
        elevation: 0,
        actions: [
          if (showLogout)
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                // Chama o método de logout e redireciona para a página de login
                AuthService authService = AuthService();
                await authService.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          if (showLogout)
            PopupMenuButton<String>(
              icon: Icon(Icons.menu, color: Colors.white),
              onSelected: (String value) {
                switch (value) {
                  case 'Bateria':
                    Navigator.pushNamed(context, '/battery');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Bateria',
                    child: Text('Bateria'),
                  ),
                ];
              },
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
