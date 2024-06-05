import 'package:flutter/material.dart';
import 'package:uffluir/pages/search_arguments.dart';

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
  final List<Resultado> corridas = [
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
      destino: "GRG - Ed. Física",
      data: "2024-10-05",
      lotada: true,
    ),
  ];

  List<Resultado> getResultados(String origem, String destino, String data) {
    List<Resultado> resultados = [];
    if (origem.contains("TODOS"))
      origem = origem.split(" ")[0]; // Pega a sigla do campus
    if (destino.contains("TODOS")) destino = destino.split(" ")[0];
    corridas.forEach((corrida) {
      if (corrida.origem.contains(origem) &&
          corrida.destino.contains(destino)) {
        // Podemos pensar em uma técnica melhor para filtrar a data
        if (data.contains(corrida.data)) resultados.add(corrida);
      }
    });
    return resultados;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SearchArguments;
    final List<Resultado> resultados =
        getResultados(args.origem, args.destino, args.data);
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
        body: ListView.builder(
          itemCount: resultados.length,
          itemBuilder: (context, index) {
            final resultado = resultados[index];
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
                      resultado.motorista,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_car, color: Colors.blue),
                    title: Text(
                      'Origem: ${resultado.origem} - Destino: ${resultado.destino}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data: ${resultado.data}'),
                      ],
                    ),
                    onTap: () {
                      // Ação ao clicar no item
                    },
                  ),
                ],
              ),
            );
          },
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
