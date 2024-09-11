import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/navbar.dart';
import '../components/lanchonete_card.dart';
import '../components/bottom_navigation_bar.dart'; // Importe o BottomNavigationBar

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> lanchonetes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLanchonetes();
  }

  Future<void> fetchLanchonetes() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-agendaai.vercel.app/lanchonete'), // Insira a URL correta da API
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          lanchonetes = json.decode(response.body);
          isLoading = false;
        });
      } else {
        showError('Erro ao buscar lanchonetes.');
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
          : ListView.builder(
              itemCount: lanchonetes.length,
              itemBuilder: (context, index) {
                return LanchoneteCard(lanchonete: lanchonetes[index]);
              },
            ),
      bottomNavigationBar: CustomBottomNavigationBar(), // Adiciona o BottomNavigationBar
    );
  }
}
