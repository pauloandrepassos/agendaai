import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class GerenteHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home',),
      body: Center(
        child: Text('Página inicial (gerente)'),
      ),
    );
  }
}
