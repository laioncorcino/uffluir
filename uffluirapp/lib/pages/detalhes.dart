import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uffluir/models/ride.dart';
import 'package:uffluir/models/ride_user.dart';
import 'package:uffluir/models/singletonUser.dart';
import 'customBottonNavigationBar.dart';
import 'screen_arguments.dart';

/*class DetalhesCarona {
  final int id;
  final int id_motorista;
  final List<int> id_passageiros;
  final String origem;
  final String destino;
  final String data;
  final String status;
  final int vagas;

  DetalhesCarona({
    required this.id,
    required this.id_motorista,
    required this.id_passageiros,
    required this.origem,
    required this.destino,
    required this.data,
    required this.status,
    required this.vagas,
  });
}*/

class Detalhes extends StatelessWidget {
  static const String routeName = "/detalhes";

  /*final List<DetalhesCarona> caronas = [
    DetalhesCarona(
        id: 1,
        id_motorista: 13,
        id_passageiros: [8, 27, 53],
        origem: "Largo do Machado",
        destino: "Gragoatá",
        data: "20/05/2024 - 08:00",
        status: "Confirmada",
        vagas: 0),
    DetalhesCarona(
        id: 2,
        id_motorista: 8,
        id_passageiros: [49, 62, 91],
        origem: "Largo do Machado",
        destino: "Gragoatá",
        data: "18/05/2024 - 08:00",
        status: "Disponível",
        vagas: 2)
  ];*/

  Widget _buildDetalhesCard(String title, String content) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> _buildDetalhesCards(RideModel? carona) async {
    final List<Widget> cards = [];
    final rideUsers = await getRideUsers(carona);
    if (rideUsers == []) {
      return _buildDetalhesCards2();
    }
    for (int i = 0; i < rideUsers.length; i++) {
      cards.add(_buildDetalhesCard("Nome do passageiro", rideUsers[i]));
    }
    return cards;
  }

  List<Widget> _buildDetalhesCards2() {
    final List<Widget> cards = [];
    for (int i = 0; i < 2; i++) {
      cards.add(_buildDetalhesCard("Nome do passageiro", "Não há passageiros"));
    }
    return cards;
  }

  String bottomText(String status) {
    switch (status) {
      case "Confirmada":
        return "Cancelar corrida";
      case "Lotada":
        return "Lotada";
      case "Aguardando confirmação":
        return "Cancelar solicitação";
      case "Finalizada":
        return "Avaliar corrida";
      case "Disponível":
        return "Solicitar corrida";
    }
    return "Buscar nova corrida";
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as ScreenArgumentsCarona?;
    if (args == null) {
      // Handle the case when arguments are null
      return Scaffold(
        appBar: AppBar(
          title: Text("Detalhes"),
        ),
        body: Center(
          child: Text("Nenhuma carona selecionada."),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar no topo
        title: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Detalhes",
                  style: const TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Image.asset(
              'images/passageiro-icon.png',
              height: 40,
              alignment: Alignment.centerRight,
            ),
          ],
        ),
        backgroundColor: Color(0xFF054552),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Partida: ${args.id?.departure_place ?? ""}\nDestino: ${args.id?.arrival_place ?? ""}\nData: ${args.id?.departure_date ?? ""}\nNúmero de vagas: ${args.id?.size ?? 0}',
                style: TextStyle(
                  color: Color(0xFF49454F), // Custom color for the text
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDetalhesCard(
                          "Nome do Motorista", args.id?.name ?? "")
                    ])),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Veículo: Corolla 2022 - Toyota\nPlaca AAA-AAAA\nCor: Preto',
                style: TextStyle(
                  color: Color(0xFF49454F), // Custom color for the text
                  fontSize: 16,
                ),
              ),
            ),
            /*FutureBuilder(
                future: _buildDetalhesCards(args.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return CircularProgressIndicator();
                  }
                  List<Widget>? cards = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch, // Ajuste aqui
                      children: cards!,
                    ),
                  );
                }),*/
            Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 69, 82),
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(15, 45),
                    textStyle: TextStyle(fontSize: 25),
                  ),
                  child: Text(bottomText(args.id!.status)),
                  onPressed: () async {
                    int resultado = await adicionarNaCarona(
                        args.id, UserModelSingleton().userModel);
                    if (resultado == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Adicionado com Sucesso"),
                        ),
                      );
                    }
                    if (resultado == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Corrida Lotada"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Você já está nesta corrida"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
    );
  }
}
