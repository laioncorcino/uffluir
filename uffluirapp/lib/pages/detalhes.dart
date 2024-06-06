import 'package:flutter/material.dart';
import 'dart:ui';
import 'customBottonNavigationBar.dart';
import 'screen_arguments.dart';

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class DetalhesCarona {
  final int id;
  final int id_motorista;
  final List<int> id_passageiros;
  final String origem;
  final String destino;
  final String data;

  DetalhesCarona({
    required this.id,
    required this.id_motorista,
    required this.id_passageiros,
    required this.origem,
    required this.destino,
    required this.data,
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
        data: "20/05/2024 - 08:00"),
    DetalhesCarona(
        id: 2,
        id_motorista: 8,
        id_passageiros: [49, 62, 91],
        origem: "Largo do Machado",
        destino: "Gragoatá",
        data: "18/05/2024 - 08:00")
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar no topo
        //appbar, a faixa azul em cima. Essa parte você pode colar em outras telas e só mudar o "Buscar" pelo título da tela
        title: Row(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Buscar",
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: _buildDetalhesCards(args.id),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
      /*bottomNavigationBar: BottomNavigationBar(
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
        )*/
    );
  }

  List<Widget> _buildDetalhesCards(int id) {
    final detalhesCarona = _getDetalhesCarona(id);
    final List<Widget> cards = [];

    cards.add(_buildDetalhesCard("ID", detalhesCarona.id.toString()));
    cards.add(_buildDetalhesCard(
        "Motorista", detalhesCarona.id_motorista.toString()));
    cards.add(_buildDetalhesCard(
        "Passageiros", detalhesCarona.id_passageiros.join(", ")));
    cards.add(_buildDetalhesCard("Origem", detalhesCarona.origem));
    cards.add(_buildDetalhesCard("Destino", detalhesCarona.destino));
    cards.add(_buildDetalhesCard("Data", detalhesCarona.data));

    return cards;
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

  DetalhesCarona _getDetalhesCarona(int id) {
    // Aqui você retornaria a carona correspondente ao ID passado
    // Este é apenas um exemplo estático, você deve implementar a lógica real aqui
    for (int i = 0; i < caronas.length; i++) {
      if (caronas[i].id == id) return caronas[i];
    }
    return DetalhesCarona(
      id: 1,
      id_motorista: 13,
      id_passageiros: [8, 27, 53],
      origem: "Largo do Machado",
      destino: "Gragoatá",
      data: "20/05/2024 - 08:00",
    );
  }
}
