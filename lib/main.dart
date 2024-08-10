import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './services/auth_service.dart';
import './pages/login_page.dart';
import './pages/admin_home_page.dart';
import './pages/cliente_home_page.dart';
import './pages/gerente_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda AI',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      //initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/admin_home': (context) => AdminHomePage(),
        '/cliente_home': (context) => ClienteHomePage(),
        '/gerente_home': (context) => GerenteHomePage(),
      },
      home: FutureBuilder(
        future: _checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            String? papel = snapshot.data as String?;
            
            if (papel == null) {
              return LoginPage();
            }

            if (papel == 'admin') {
              return AdminHomePage();
            } else if (papel == 'cliente') {
              return ClienteHomePage();
            } else {
              return GerenteHomePage();
            }
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }

  Future<String?> _checkAuth() async {
    AuthService authService = AuthService();
    bool isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      return await authService.getPapel();
    }
    return null;
  }
}
