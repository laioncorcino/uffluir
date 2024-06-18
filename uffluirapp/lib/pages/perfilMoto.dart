import 'package:flutter/material.dart';
import 'package:uffluir/models/user.dart';
import 'dart:ui';

import 'package:uffluir/pages/screen_arguments.dart';

class PerfilMoto extends StatefulWidget {
  String message = "";
  static const String routeName = "/perfilMoto";
  PerfilMoto();

  @override
  State<PerfilMoto> createState() => _PerfilMotoState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _PerfilMotoState extends State<PerfilMoto> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScreenArgumentsPerfil;
    final UserModel userModel = args.userModel;
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
                Navigator.pushNamed(context, '/perfil', arguments: args);
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
                    padding: EdgeInsets.only(top: 35, left: 40),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(userModel.photoUrl))),
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
                      child: Text(userModel.nome,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0, left: 15),
                      width: 200,
                      height: 20,
                      child:
                          Text(userModel.email, style: TextStyle(fontSize: 13)),
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
