import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:uffluir/pages/customBottonNavigationBar.dart';

class SupportMoto extends StatefulWidget {
  String message = "";
  static const String routeName = "/supportMoto";
  SupportMoto();

  @override
  State<SupportMoto> createState() => _SupportMotoState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _SupportMotoState extends State<SupportMoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar no topo
        //appbar, a faixa azul em cima. Essa parte você pode colar em outras telas e só mudar o "Buscar" pelo título da tela
        title: Row(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Suporte",
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      )))),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/support');
            }, // Image tapped
            child: Image.asset(
              'images/motorista-icon.png',
              height: 40,
              alignment: Alignment.centerRight,
            ),
          )
        ]),
        backgroundColor: Color.fromARGB(255, 153, 77, 0),
      ), //fim da appbar
      body: ListView(),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'motorista'),
    );
  }
}
