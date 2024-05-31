import 'package:flutter/material.dart';
import 'dart:ui';
import 'support.dart';
import 'home.dart';
import 'minhasCaronas.dart';
import 'supportMoto.dart';
import 'homeMoto.dart';

class PerfilMoto extends StatefulWidget {
  const PerfilMoto({super.key});

  @override
  State<PerfilMoto> createState() => _PerfilMotoState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _PerfilMotoState extends State<PerfilMoto> {
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
                    child: Text("Perfil",
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        )))),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
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
        body: Row(
          children: [
            Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Image.asset(
                  'images/avatar.png',
                  height: 75,
                )),
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 7, left: 15),
                  width: 200,
                  child: Text('Nome do Usuário',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 7, left: 15),
                  width: 200,
                  child: Text('Sei la', style: TextStyle(fontSize: 13)),
                ),
              ],
            )),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          //tela fixa do final da tela, é a mesma coisa da appbar só que no final. Pode colar em outras telas igualzinho
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: Color.fromARGB(255, 54, 54, 54),
          unselectedItemColor: Color.fromARGB(255, 54, 54, 54),
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => {Navigator.pushNamed(context, '/homeMoto')},
                ), //
                label: 'Home'),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.help),
                onPressed: () => {Navigator.pushNamed(context, '/supportMoto')},
              ), //Icone de Suporte
              label: 'Suporte',

              //activeIcon: PerfilMoto()
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
                onPressed: () => {Navigator.pushNamed(context, '/perfilMoto')},
              ), //Icone PerfilMoto
              label: 'Perfil',
            )
          ],
        ));
  }
}
