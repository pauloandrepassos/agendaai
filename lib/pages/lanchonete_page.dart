import 'package:agendaai/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class LanchoneteDetalhesPage extends StatelessWidget {
  final Map<String, dynamic> lanchonete;

  LanchoneteDetalhesPage({required this.lanchonete});

  @override
  Widget build(BuildContext context) {
    final endereco = lanchonete['endereco'];

    return Scaffold(
      appBar: CustomAppBar(title: 'Lacnhonete',),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(lanchonete['imagem'], fit: BoxFit.cover),
            SizedBox(height: 16.0),
            Text(
              lanchonete['nome'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Endereço: ${endereco['logradouro']}, ${endereco['numero']}, ${endereco['bairro']}, ${endereco['cidade']} - ${endereco['estado']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'CNPJ: ${lanchonete['cnpj']}',
              style: TextStyle(fontSize: 16),
            ),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
    );
  }
}
