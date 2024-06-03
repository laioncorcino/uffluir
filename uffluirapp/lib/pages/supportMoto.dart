import 'package:flutter/material.dart';
import 'dart:ui';
import 'home.dart';
import 'perfil.dart';
import 'minhasCaronas.dart';
import 'perfilMoto.dart';

class SupportMoto extends StatefulWidget {
  const SupportMoto({super.key});

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

              //activeIcon: SupportMoto()
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
              ), //Icone Perfil
              label: 'Perfil',
            )
          ],
        ));
  }
}
