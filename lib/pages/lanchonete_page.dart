import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/bottom_navigation_bar.dart';
import '../components/navbar.dart';

class LanchonetePage extends StatefulWidget {
  final Map<String, dynamic> lanchonete;

  LanchonetePage({required this.lanchonete});

  @override
  _LanchonetePageState createState() => _LanchonetePageState();
}

class _LanchonetePageState extends State<LanchonetePage> {
  List<dynamic> lanches = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLanches();
  }

  Future<void> fetchLanches() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-agendaai.vercel.app/lanchonete/${widget.lanchonete['id']}/lanche'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          lanches = json.decode(response.body);
          isLoading = false;
        });
      } else {
        showError('Erro ao buscar lanches.');
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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.lanchonete['imagem'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.lanchonete['nome'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.location_on, color: Colors.red),
                          label: Text(
                            '${widget.lanchonete['endereco']['logradouro']}, ${widget.lanchonete['endereco']['numero']}, ${widget.lanchonete['endereco']['bairro']}, ${widget.lanchonete['endereco']['cidade']}, ${widget.lanchonete['endereco']['estado']}, ${widget.lanchonete['endereco']['cep']}',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: Text(
                      'Lanches Disponíveis',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: lanches.length,
                    itemBuilder: (context, index) {
                      final lanche = lanches[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                              child: AspectRatio(
                                aspectRatio: 1, // Define o formato 1x1 para a imagem
                                child: Image.network(
                                  lanche['imagem'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              lanche['nome'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis, // Abrevia o texto com "..."
                              maxLines: 1, // Garante que o texto tenha apenas uma linha
                            ),
                            SizedBox(height: 4),
                            Text(
                              'R\$ ${lanche['preco'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
