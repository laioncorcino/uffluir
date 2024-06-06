import 'package:flutter/material.dart';
import 'customBottonNavigationBar.dart';
import 'screen_arguments.dart';

class DetalhesCarona {
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
}

class Detalhes extends StatelessWidget {
  static const String routeName = "/detalhes";

  final List<DetalhesCarona> caronas = [
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
  ];

  DetalhesCarona _getDetalhesCarona(int id) {
    for (int i = 0; i < caronas.length; i++) {
      if (caronas[i].id == id) return caronas[i];
    }
    // Retorna uma carona padrão caso o ID não seja encontrado
    return DetalhesCarona(
        id: 1,
        id_motorista: 13,
        id_passageiros: [8, 27, 53],
        origem: "Largo do Machado",
        destino: "Gragoatá",
        data: "20/05/2024 - 08:00",
        status: "Aguardando confirmação",
        vagas: 0);
  }

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

  List<Widget> _buildDetalhesCards(DetalhesCarona carona) {
    final List<Widget> cards = [];
    carona.id_passageiros.forEach((id) {
      cards.add(_buildDetalhesCard("ID do passageiro", id.toString()));
    });
    return cards;
  }

  String bottomText(String status) {
    switch (status) {
      case "Confirmada":
        return "Cancelar corrida";
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
    final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments?;
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

    final DetalhesCarona carona = _getDetalhesCarona(args.id);
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
                'Partida: ${carona.origem}\nDestino: ${carona.destino}\nData: ${carona.data}\nNúmero de vagas: ${carona.vagas}',
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
                          "ID do motorista", carona.id_motorista.toString())
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
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Ajuste aqui
                children: _buildDetalhesCards(carona),
              ),
            ),
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
                  child: Text(bottomText(carona.status)),
                  onPressed: () {
                    print('Botão de detalhes pressionado');
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
