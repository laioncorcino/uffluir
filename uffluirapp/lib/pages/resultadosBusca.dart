import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uffluir/models/ride.dart';
import 'package:uffluir/models/user.dart';
import 'package:uffluir/pages/detalhes.dart';
import 'package:uffluir/pages/screen_arguments.dart';
import 'package:uffluir/pages/search_arguments.dart';

import 'customBottonNavigationBar.dart';

class Resultado {
  final int id; // Representa a chave primária do banco de dados
  final String motorista;
  final String origem;
  final String destino;
  final String data;
  final bool lotada;

  Resultado({
    required this.id,
    required this.motorista,
    required this.origem,
    required this.destino,
    required this.data,
    required this.lotada,
  });
}

class ResultadosBusca extends StatefulWidget {
  String message = "";
  static const String routeName = "/resultadosBusca";
  ResultadosBusca();

  @override
  State<ResultadosBusca> createState() => _ResultadosBuscaState();
}

class _ResultadosBuscaState extends State<ResultadosBusca> {
  // Quando usar a API, vamos precisar de uma função async que retorne uma lista do tipo Future
  /*final List<Resultado> corridas = [
    Resultado(
      id: 1,
      motorista: "João da Silva",
      origem: "GRG - Cantareira",
      destino: "VAL - Ent. Principal",
      data: "2024-11-02",
      lotada: false,
    ),
    Resultado(
      id: 2,
      motorista: "João da Silva",
      origem: "PRV - Jambeiro",
      destino: "VAL - Rua do Perdeu",
      data: "2024-09-03",
      lotada: false,
    ),
    Resultado(
      id: 3,
      motorista: "João da Silva",
      origem: "GRG - Cantareira",
      destino: "GRG - TODOS",
      data: "2024-10-05",
      lotada: true,
    ),
  ];*/

  Future<List<RideModel>> getResultados(
      String origem, String destino, String data) async {
    final List<RideModel> corridas = await RideService().getRides();
    List<RideModel> resultados = [];
    if (origem.contains("TODOS"))
      origem = origem.split(" ")[0]; // Pega a sigla do campus
    if (destino.contains("TODOS")) destino = destino.split(" ")[0];
    corridas.forEach((corrida) {
      if (corrida.departure_place.contains(origem) &&
          corrida.arrival_place.contains(destino)) {
        // Podemos pensar em uma técnica melhor para filtrar a data
        if (data.contains(corrida.departure_date)) resultados.add(corrida);
      }
    });
    return resultados;
  }

  /*Future<List<UserModel?>> getDrivers(List<RideModel> corridas) async {
    List<UserModel?> drivers = [];
    for (int i = 0; i < corridas.length; i++) {
      UserModel? driver = await obtemInfoUsuario(corridas[i].rider_id);
      drivers.add(driver);
    }
    return drivers;
  }*/

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SearchArguments;
    /*final Future<List<RideModel>> resultados =
        getResultados(args.origem, args.destino, args.data);*/

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar no topo
        //appbar, a faixa azul em cima. Essa parte você pode colar em outras telas e só mudar o "Buscar" pelo título da tela
        title: Row(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Resultados da Busca",
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      )))),
        ]),
        backgroundColor: Color(0xFF054552),
      ),
      body: FutureBuilder(
        future: getResultados(args.origem, args.destino, args.data),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final resultado = snapshot.data?[index];
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
                          resultado?.name ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car, color: Colors.blue),
                        title: Text(
                          'Origem: ${resultado?.departure_place ?? ""} - Destino: ${resultado?.arrival_place ?? ""}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Data: ${resultado?.departure_date ?? ""}'),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Detalhes.routeName,
                            arguments: ScreenArgumentsCarona(resultado),
                          );
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
    );
  }
}
