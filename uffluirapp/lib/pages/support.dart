import 'package:flutter/material.dart';
import 'dart:ui';
import 'customBottonNavigationBar.dart';

class Support extends StatefulWidget {
  String message = "";
  static const String routeName = "/support";
  Support();

  @override
  State<Support> createState() => _SupportState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _SupportState extends State<Support> {
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
              Navigator.pushNamed(context, '/supportMoto');
            }, // Image tapped
            child: Image.asset(
              'images/passageiro-icon.png',
              height: 40,
              alignment: Alignment.centerRight,
            ),
          )
        ]),
        backgroundColor: Color(0xFF054552),
      ), //fim da appbar
      body: ListView(),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
    );
  }
}
