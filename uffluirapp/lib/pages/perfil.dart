import 'package:flutter/material.dart';
import 'dart:ui';
import 'support.dart';
import 'home.dart';
import 'minhasCaronas.dart';
import 'perfilMoto.dart';

class Perfil extends StatefulWidget {
  String message = "";
  static const String routeName = "/perfil";
  Perfil();

  @override
  State<Perfil> createState() => _PerfilState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _PerfilState extends State<Perfil> {
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
                Navigator.pushNamed(context, '/perfilMoto');
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Flexible(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30, left: 40),
                    child: Image.asset(
                      'images/avatar.png',
                      width: 90,
                    )),
                Flexible(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 35, left: 15),
                      width: 200,
                      height: 55,
                      child: Text('Nome do Usuário',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0, left: 15),
                      width: 200,
                      height: 20,
                      child: Text('usuario@email.com',
                          style: TextStyle(fontSize: 13)),
                    ),
                    Flexible(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          padding: EdgeInsets.only(top: 0, left: 12),
                          child: Icon(Icons.star),
                        ),
                        Container(
                          child: Icon(Icons.star),
                        ),
                        Container(
                          child: Icon(Icons.star_half_outlined),
                        ),
                        Container(
                          child: Icon(Icons.star_border),
                        ),
                        Container(
                          child: Icon(Icons.star_border),
                        ),
                      ],
                    ))
                  ],
                )),
              ],
            ))),
            Container(
              padding: EdgeInsets.only(top: 20, left: 0),
              child: SizedBox(
                width: 300,
                height: 120,
                child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 8, left: 15),
                            child: Text('Nome do Usuário',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8, left: 15),
                            child: Text(
                              'oiiiiiii vc eh legau',
                            ),
                          ),
                        ]),
                    color: Color.fromARGB(255, 205, 207, 208)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 0),
              child: SizedBox(
                width: 300,
                height: 120,
                child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 8, left: 15),
                            child: Text('Nome do Usuário',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8, left: 15),
                            child: Text(
                              'oiiiiiii vc naum eh legau',
                            ),
                          ),
                        ]),
                    color: Color.fromARGB(255, 205, 207, 208)),
              ),
            ),
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
                  onPressed: () => {Navigator.pushNamed(context, '/home')},
                ), //
                label: 'Home'),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.help),
                onPressed: () => {Navigator.pushNamed(context, '/support')},
              ), //Icone de Suporte
              label: 'Suporte',

              //activeIcon: Perfil()
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
