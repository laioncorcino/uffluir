import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uffluir/models/ride.dart';
import 'package:uffluir/models/singletonUser.dart';
import 'package:uffluir/models/user.dart';
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
    Future<List<RideModel>> fetchRides(String userID) async {
      print("ID do usuário: ${userID}");
      List<RideModel> rides = [];
      QuerySnapshot rideUserSnapshot = await FirebaseFirestore.instance
          .collection('ride_user')
          .where('user_id', isEqualTo: userID)
          .get();

      List<String> rideIds =
          rideUserSnapshot.docs.map((doc) => doc['ride_id'] as String).toList();

      print("IDs corridas: ${rideIds}");

      for (String rideId in rideIds) {
        DocumentSnapshot rideSnapshot = await FirebaseFirestore.instance
            .collection('ride')
            .doc(rideId)
            .get();
        if (rideSnapshot.exists) {
          rides.add(RideModel.fromFirestore(
              rideSnapshot.id, rideSnapshot.data() as Map<String, dynamic>));
        }
      }

      return rides;
    }

    final user = UserModelSingleton().userModel;
    final String userId = user.id;

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
      body: FutureBuilder<List<RideModel>>(
        future: fetchRides(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar as caronas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma carona encontrada'));
          } else {
            List<RideModel> caronas = snapshot.data!;
            return ListView.builder(
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
                          carona.status,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car,
                            color: Color(0xFF2D6371)),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              carona.departure_place,
                              style: TextStyle(
                                color: Color(0xFF2D6371),
                              ),
                            ),
                            Text(
                              carona.departure_date,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              carona.arrival_place,
                              style: TextStyle(
                                color: Color(0xFF2D6371),
                              ),
                            ),
                            Text(
                              carona.name,
                              style: TextStyle(
                                color: Color(0xFF2D6371),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Detalhes.routeName,
                            arguments: carona,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
    );
  }
}
