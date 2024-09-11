import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart'; // Adicione essa dependência no pubspec.yaml
import 'pages/login_page.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(),
      navigatorObservers: [TokenObserver()], // Adiciona o observer para verificar o token
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && !isTokenExpired(token)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      await prefs.remove('token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  bool isTokenExpired(String token) {
    // Verifica se o token está expirado
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    int exp = payload['exp'] * 1000; // Conversão para milissegundos
    return DateTime.now().millisecondsSinceEpoch > exp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// TokenObserver é um NavigatorObserver para verificar o token em cada navegação
class TokenObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) async {
    await checkToken();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) async {
    await checkToken();
    super.didPop(route, previousRoute);
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && isTokenExpired(token)) {
      await prefs.remove('token');
      // Recarrega para garantir que o usuário vá para a tela de login
      Navigator.of(navigator!.context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  bool isTokenExpired(String token) {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      int exp = payload['exp'] * 1000; // Conversão para milissegundos
      return DateTime.now().millisecondsSinceEpoch > exp;
    } catch (e) {
      // Caso ocorra erro na verificação, considera o token como expirado
      return true;
    }
  }
}
