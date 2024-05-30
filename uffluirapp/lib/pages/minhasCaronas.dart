import 'package:flutter/material.dart';
import 'dart:ui';
import 'detalhes.dart';
import 'screen_arguments.dart';
import 'support.dart';
import 'home.dart';
import 'perfil.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// Esta classe é apenas um representação do que será exibido para o usuário
class Carona {
  final int id; // Representa a chave primária do banco de dados
  final String origem;
  final String destino;
  final String data;
  final String funcao;
  final String confirmada;

  Carona({
    required this.id,
    required this.origem,
    required this.destino,
    required this.data,
    required this.funcao,
    required this.confirmada,
  });
}

class MinhasCaronas extends StatefulWidget {
  String message = "";
  static const String routeName = "/minhasCaronas";
  MinhasCaronas();

  MinhasCaronas.arguments(this.message);

  @override
  State<MinhasCaronas> createState() => _MinhasCaronasState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

// Essa classe deve ser populada pelas informações do banco de dados
class _MinhasCaronasState extends State<MinhasCaronas> {
  final List<Carona> caronas = [
    Carona(
        id: 1,
        origem: "Largo do Machado",
        destino: "Gragoatá",
        data: "20/05/2024 - 08:00",
        funcao: "Passageiro(a)",
        confirmada: "Aguardando confirmação"),
    Carona(
        id: 2,
        origem: "Largo do Machado",
        destino: "Gragoatá",
        data: "18/05/2024 - 08:00",
        funcao: "Motorista",
        confirmada: "Confirmada"),
    Carona(
        id: 3,
        origem: "Gragoatá",
        destino: "Largo do Machado",
        data: "20/05/2024 - 18:00",
        funcao: "Passageiro(a)",
        confirmada: "Cancelada"),
    Carona(
        id: 4,
        origem: "Gragoatá",
        destino: "Largo do Machado",
        data: "18/05/2024 - 18:00",
        funcao: "Motorista",
        confirmada: "Confirmada"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove o botão de voltar no topo
          title: Row(children: [
            Container(
                padding: EdgeInsets.only(left: 8, right: size.width / 5.5),
                child: Text("Minhas Caronas",
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
        body: ListView.builder(
          itemCount: caronas.length,
          itemBuilder: (context, index) {
            final carona = caronas[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.green,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      carona.confirmada,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_car, color: Colors.blue),
                    title: Text(
                      'Origem: ${carona.origem} - Destino: ${carona.destino}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data: ${carona.data}'),
                        Text('Função: ${carona.funcao}'),
                      ],
                    ),
                    onTap: () {
                      // Ação ao clicar no item
                      Navigator.pushNamed(context, Detalhes.routeName,
                          arguments: ScreenArguments(carona.id));
                    },
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 0, 71, 159),
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => {Navigator.pushNamed(context, '/home')},
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.help),
                onPressed: () => {Navigator.pushNamed(context, '/support')},
              ),
              label: 'Suporte',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.time_to_leave),
                onPressed: () =>
                    {Navigator.pushNamed(context, '/minhasCaronas')},
              ),
              label: 'Minhas Caronas',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person),
                onPressed: () => {Navigator.pushNamed(context, '/perfil')},
              ),
              label: 'Perfil',
            )
          ],
        ));
  }
}
