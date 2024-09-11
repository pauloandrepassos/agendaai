import 'package:flutter/material.dart';
import '../components/bottom_navigation_bar.dart';
import '../components/navbar.dart';

class CestoPage extends StatefulWidget {
  @override
  _CestoPageState createState() => _CestoPageState();
}

class _CestoPageState extends State<CestoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text("página de cesto de compras")
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
