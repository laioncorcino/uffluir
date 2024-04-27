import 'package:flutter/material.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _HomeState extends State<Home> {
  String pesquisa = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Container(
                padding: EdgeInsets.only(left: 8, right: size.width / 5),
                child: Text("Buscar",
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
        ),
        body: ListView(children: [
          Stack(children: [
            Stack(children: [
              Padding(
                  padding: EdgeInsets.only(top: 45, left: 35, right: 35),
                  child: SearchBar(
                    leading:
                        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                    hintText: "Local de Partida",
                    hintStyle: MaterialStateProperty.all(TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(165, 0, 79, 121)),
                    trailing: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      )
                    ],
                  )),
            ]),
            Padding(
                padding: EdgeInsets.only(top: 245, left: 35, right: 35),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    SearchBar(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(165, 0, 79, 121)),
                      leading:
                          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                      hintText: "Destino",
                      hintStyle: MaterialStateProperty.all(TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20)),
                      trailing: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        )
                      ],
                    )
                  ],
                )),
          ]),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixed
          backgroundColor:
              Color.fromARGB(255, 0, 71, 159), // <-- This works for fixed
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Suporte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_rental),
              label: 'Minhas Caronas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            )
          ],
        ));
  }
}
