import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/bottom_navigation_bar.dart';
import '../components/navbar.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String? nome;
  String? email;
  String? imagem;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');

    if (storedToken == null) {
      // Redireciona para a página de login se o token não estiver no cache
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://api-agendaai.vercel.app/user'), // Altere para a URL correta da API
        headers: {
          'token': storedToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nome = data['nome'];
          email = data['email'];
          imagem = data['imagem'];
          isLoading = false;
        });
      } else {
        showError('Erro ao buscar os dados do usuário.');
      }
    } catch (e) {
      showError('Erro ao conectar com o servidor.');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: imagem != null
                          ? NetworkImage(imagem!)
                          : AssetImage('assets/placeholder.png')
                              as ImageProvider, // Placeholder caso a imagem seja nula
                    ),
                    SizedBox(height: 20),
                    Text(
                      nome ?? 'Nome não disponível',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      email ?? 'Email não disponível',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
