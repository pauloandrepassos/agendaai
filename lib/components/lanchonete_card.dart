import 'package:flutter/material.dart';
import '../pages/lanchonete_page.dart'; // Importe a página da lanchonete

class LanchoneteCard extends StatelessWidget {
  final Map<String, dynamic> lanchonete;

  LanchoneteCard({required this.lanchonete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navega para a página da lanchonete ao clicar no card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanchonetePage(lanchonete: lanchonete),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                lanchonete['imagem'],
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lanchonete['nome'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${lanchonete['endereco']['logradouro']}, ${lanchonete['endereco']['numero']}, ${lanchonete['endereco']['bairro']} - ${lanchonete['endereco']['cidade']}, ${lanchonete['endereco']['estado']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
