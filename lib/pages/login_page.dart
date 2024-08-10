import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar url_launcher
import '../services/auth_service.dart';
import 'admin_home_page.dart';
import 'cliente_home_page.dart';
import 'gerente_home_page.dart';
import 'package:agendaai/widgets/app_bar.dart'; // Importando o CustomAppBar

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    AuthService authService = AuthService();

    try {
      await authService.login(email, password);
      String? papel = await authService.getPapel();
      
      if (papel == null) {
        setState(() {
          _errorMessage = "Erro ao obter o papel do usuário.";
        });
        return;
      }

      if (papel == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage()),
        );
      } else if (papel == 'cliente') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ClienteHomePage()),
        );
      } else if (papel == 'gerente') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GerenteHomePage()),
        );
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    }
  }

  Future<void> _launchURL() async {
    const url = 'https://agendaai.vercel.app/auth/signup'; // Substitua pela URL real
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Login', showLogout: false,),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFA680F), // #FA680F
              Color(0xFFFA240F), // #FA240F
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Color(0XFFFDF1CF),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFA240F),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFfdf6e3),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0xFFFA240F)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color(0xFFFA240F),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color(0xFFFA240F),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color(0xFFFA240F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFfdf6e3),
                        labelText: 'Senha',
                        labelStyle: TextStyle(color: Color(0xFFFA240F)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color(0xFFFA240F),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color(0xFFFA240F),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Color(0xFFFA240F),
                          ),
                        ),
                        suffixIcon:
                            Icon(Icons.visibility, color: Color(0xFFFA240F)),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: _launchURL,
                      child: Center(
                        child: Text(
                          'Ainda não possui cadastro? Cadastre-se já em nosso site',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Color(0xFFfdf6e3)),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xFFFA240F),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


