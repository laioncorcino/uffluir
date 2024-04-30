import 'package:flutter/material.dart';
import 'dart:ui';
import 'home.dart';
import 'perfil.dart';
import 'minhasCaronas.dart';

class Support extends StatefulWidget {
  const Support({super.key});

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
          //appbar, a faixa azul em cima. Essa parte você pode colar em outras telas e só mudar o "Buscar" pelo título da tela
          title: Row(children: [
            Container(
                padding: EdgeInsets.only(
                    left: 8,
                    right: size.width /
                        5.5), //a posição da imagem à direita tá definida com base na distância em relação ao texto. Foi a melhor forma de fazer que achei
                child: Text("Suporte",
                    style: const TextStyle(
                      fontSize: 30.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ))),
            Image.asset(
              'images/passageiro-icon.png',
              height: 40,
              alignment: Alignment.center,
            ),
          ]),
          backgroundColor: Color.fromARGB(255, 0, 71, 159),
        ), //fim da appbar
        body: ListView(),
        bottomNavigationBar: BottomNavigationBar(
          //tela fixa do final da tela, é a mesma coisa da appbar só que no final. Pode colar em outras telas igualzinho
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 0, 71, 159),
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => {Navigator.pushNamed(context, '/home')},
                ), //
                label: 'Home'),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.help),
                onPressed: () => {Navigator.pushNamed(context, '/support')},
              ), //Icone de Suporte
              label: 'Suporte',

              //activeIcon: Support()
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.time_to_leave),
                onPressed: () =>
                    {Navigator.pushNamed(context, '/minhasCaronas')},
              ), //Icone de Carro no "Minhas Caronas"
              label: 'Minhas Caronas',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person),
                onPressed: () => {Navigator.pushNamed(context, '/perfil')},
              ), //Icone Perfil
              label: 'Perfil',
            )
          ],
        ));
  }
}
