import 'package:flutter/material.dart';
import '../components/bottom_navigation_bar.dart';
import '../components/navbar.dart';

class PedidosPage extends StatefulWidget {
  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text("página de pedidos")
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
