import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/home_page.dart';
import '../pages/cesto_page.dart';
import '../pages/pedidos_page.dart';
import '../pages/perfil_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  // Função para lidar com a mudança de índice ao clicar nos ícones
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navegação baseada no índice
    switch (_selectedIndex) {
      case 0:
        // Redireciona para a HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CestoPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PedidosPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PerfilPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),  // Ícone de Home
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.basketShopping),  // Ícone de Cesto de Compras
          label: 'Cesto de Compras',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.clipboardList),  // Ícone de Pedidos
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),  // Ícone de Perfil
          label: 'Perfil',
        ),
      ],
      backgroundColor: Color(0xFFFA240F), // Cor de fundo da BottomNavigationBar
      selectedItemColor: Color(0xFFEEFF00), // Cor do ícone selecionado
      unselectedItemColor: Colors.white, // Cor dos ícones não selecionados
      type: BottomNavigationBarType.fixed, // Define o tipo para evitar animações que mudam a cor
    );
  }
}
