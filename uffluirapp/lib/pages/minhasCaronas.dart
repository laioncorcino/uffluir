import 'package:flutter/material.dart';
import 'dart:ui';
import 'customBottonNavigationBar.dart';
import 'detalhes.dart';
import 'screen_arguments.dart';

import 'package:flutter/src/widgets/framework.dart';

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

//FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
//Size size = view.physicalSize;

// Essa classe deve ser populada pelas informações do banco de dados
// Quando usar a API, vamos precisar de uma função async que retorne uma lista do tipo Future

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
        //appbar, a faixa azul em cima. Essa parte você pode colar em outras telas e só mudar o "Buscar" pelo título da tela
        title: Row(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Minhas Caronas",
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      )))),
          Image.asset(
            'images/passageiro-icon.png',
            height: 40,
            alignment: Alignment.centerRight,
          ),
        ]),
        backgroundColor: Color(0xFF054552),
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
                  color: Color(0xFF054552),
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
                  leading: Icon(Icons.directions_car, color: Color(0xFF2D6371)),
                  title: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Centralize os textos
                    children: [
                      Text(
                        carona.origem,
                        style: TextStyle(
                          color: Color(0xFF2D6371),
                        ),
                      ),
                      Text(
                        carona.data,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        carona.destino,
                        style: TextStyle(
                          color: Color(0xFF2D6371),
                        ),
                      ),
                      Text(
                        carona.funcao,
                        style: TextStyle(
                          color: Color(0xFF2D6371),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Ação ao clicar no item
                    Navigator.pushNamed(
                      context,
                      Detalhes.routeName,
                      arguments: ScreenArguments(carona.id),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
    );
  }
}
