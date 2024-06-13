// custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';

import 'home.dart';
import 'homeMoto.dart';
import 'perfil.dart';
import 'perfilMoto.dart';
import 'support.dart';
import 'supportMoto.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String role;

  CustomBottomNavigationBar({required this.role});

  @override
  Widget build(BuildContext context) {
    List<String> routes(String role) {
      List<String> home_support_perfil;
      if (role == 'motorista') {
        home_support_perfil = [
          HomeMoto.routeName,
          PerfilMoto.routeName,
          SupportMoto.routeName
        ];
        return home_support_perfil;
      }
      home_support_perfil = [
        Home.routeName,
        Support.routeName,
        Perfil.routeName
      ];
      return home_support_perfil;
    }

    List<String> h_s_p = routes(role);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: Color.fromARGB(255, 54, 54, 54),
      unselectedItemColor: Color.fromARGB(255, 54, 54, 54),
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () => {Navigator.pushNamed(context, h_s_p[0])},
            ),
            label: 'Home'),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.help),
            onPressed: () => {Navigator.pushNamed(context, h_s_p[1])},
          ),
          label: 'Suporte',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.time_to_leave),
            onPressed: () => {Navigator.pushNamed(context, '/minhasCaronas')},
          ),
          label: 'Minhas Caronas',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(Icons.person),
            onPressed: () => {Navigator.pushNamed(context, h_s_p[2])},
          ),
          label: 'Perfil',
        )
      ],
    );
  }
}
