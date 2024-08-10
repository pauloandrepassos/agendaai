import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/app_bar.dart';
import 'lanchonete_page.dart';  // Importe a nova página

class ClienteHomePage extends StatefulWidget {
  @override
  _ClienteHomePageState createState() => _ClienteHomePageState();
}

class _ClienteHomePageState extends State<ClienteHomePage> {
  List<dynamic> lanchonetes = [];

  @override
  void initState() {
    super.initState();
    fetchLanchonetes();
  }

  Future<void> fetchLanchonetes() async {
    final response = await http.get(Uri.parse('https://api-agendaai.vercel.app/lanchonete'));

    if (response.statusCode == 200) {
      setState(() {
        lanchonetes = json.decode(response.body);
      });
    } else {
      // Tratamento de erro
      print('Erro ao buscar lanchonetes: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: ListView.builder(
        itemCount: lanchonetes.length,
        itemBuilder: (context, index) {
          final lanchonete = lanchonetes[index];
          final endereco = lanchonete['endereco'];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(lanchonete['imagem'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(lanchonete['nome']),
              subtitle: Text('${endereco['bairro']}, ${endereco['cidade']}, ${endereco['estado']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanchoneteDetalhesPage(lanchonete: lanchonete),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
