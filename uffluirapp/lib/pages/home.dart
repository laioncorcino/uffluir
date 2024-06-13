import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:uffluir/pages/search_arguments.dart';
import 'dart:ui';
import 'customBottonNavigationBar.dart';
import 'screen_arguments.dart';
import 'support.dart';
import 'minhasCaronas.dart';
import 'perfil.dart';
import 'homeMoto.dart';
import 'resultadosBusca.dart';

class Home extends StatefulWidget {
  String message = "";
  static const String routeName = "/home";
  Home();

  @override
  State<Home> createState() => _HomeState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _HomeState extends State<Home> {
  // Controladores
  TextEditingController _dateController = TextEditingController();
  TimeOfDay _hourSelect = TimeOfDay
      .now(); //esse aqui é pra ele "começar" na hora atual, explico la embaixo
  TextEditingController _hourController = TextEditingController();
  final TextEditingController _partidaController = TextEditingController();

  // Lista de sugestões para as barras de pesquisa
  List<String> partidaSuggestions = [
    'GRG - TODOS',
    'GRG - Cantareira',
    'GRG - Ed. Física',
    'PRV - Jambeiro',
    'PRV - Orla',
    'VAL - Ent. Principal',
    'VAL - Rua do Perdeu'
  ];
  List<String> filteredPartidaSuggestions = [];

  @override
  void initState() {
    super.initState();
    _partidaController.addListener(_onPartidaSearchChanged);
    filteredPartidaSuggestions.addAll(partidaSuggestions);
  }

  @override
  void dispose() {
    _partidaController.dispose();
    super.dispose();
  }

  void _onPartidaSearchChanged() {
    setState(() {
      filteredPartidaSuggestions = partidaSuggestions
          .where((suggestion) => suggestion
              .toLowerCase()
              .contains(_partidaController.text.toLowerCase()))
          .toList();
    });
  }

  Widget build(BuildContext context) {
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/homeMoto');
            }, // Image tapped
            child: Image.asset(
              'images/passageiro-icon.png',
              height: 40,
              alignment: Alignment.centerRight,
            ),
          )
        ]),
        backgroundColor: Color(0xFF054552),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: 45,
                      left: 35,
                      right:
                          35), //valores precisam ser atualizados pra ficar em função da tela
                  child: Column(
                    children: [
                      TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          controller: _partidaController,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Local de Partida',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                            ),
                            filled: true,
                            fillColor: Color(0xFF558190),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                // Implemente a ação desejada quando o ícone é pressionado
                              },
                              color: Colors.white,
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return partidaSuggestions
                              .where((local) => local
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return Container(
                            color: Color(0xFF558190), // Cor de fundo azul
                            child: ListTile(
                              title: Text(
                                suggestion,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          _partidaController.text = suggestion;
                          print('Local selecionado: $suggestion');
                        },
                      ),
                    ],
                  )
                  /*SearchBar(
                    //aqui é a primeira SearchBar, a de local de partida
                    textStyle: MaterialStateProperty.all(TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                    leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu)), //icone da esquerda
                    controller: _partidaController,
                    hintText: 'Local de Partida',
                    hintStyle: MaterialStateProperty.all(TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(165, 5, 69, 82)),
                    trailing: [
                      //icone da direita
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      )
                    ],
                  ),*/
                  ),
              Padding(
                  //imagem do mapa
                  padding: EdgeInsets.only(
                      right: 35,
                      left:
                          35), //valores precisam ser atualizados pra ficar em função da tela
                  child: Image.asset(
                    'images/ImagemMapa.png',
                    width: 500,
                    height:
                        150, //valores precisam ser atualizados pra ficar em função da tela
                    alignment: Alignment.center,
                  )),
              Padding(
                  //mais uma search bar, essa é a de destino
                  padding: EdgeInsets.only(
                      left: 35,
                      right:
                          35), //valores precisam ser atualizados pra ficar em função da tela
                  child: SearchBar(
                    textStyle: MaterialStateProperty.all(TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(165, 5, 69, 82)),
                    leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu)), //icone da esquerda
                    hintText: "Destino",
                    hintStyle: MaterialStateProperty.all(TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                    trailing: [
                      //icone da direita
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      )
                    ],
                  )),
              Padding(
                  //bloco de data
                  padding: EdgeInsets.only(top: 20, right: 35, left: 35),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller:
                        _dateController, //chamar o controller de data pra atualizar o texto
                    decoration: InputDecoration(
                      labelText: 'Data',
                      filled: true,
                      fillColor: Color.fromARGB(255, 205, 203, 203),
                      suffixIcon: Icon(Icons.calendar_today),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 5, 69, 82))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 5, 69, 82))),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate(); //chama a função de seleção de data(tá no final do codigo)
                    },
                  )),
              Padding(
                  //bloco de hora
                  padding: EdgeInsets.only(top: 20, right: 35, left: 35),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller:
                        _hourController, //chama o controller de hora pra atualizar o texto
                    decoration: InputDecoration(
                      labelText: 'Hora',
                      filled: true,
                      fillColor: Color.fromARGB(255, 205, 203, 203),
                      suffixIcon: Icon(Icons.timer),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 5, 69, 82))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 5, 69, 82))),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectTime(); //chama a função de selecionar hora quando clicado
                    },
                  )),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 69, 82),
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    minimumSize: Size(15, 45),
                    textStyle: TextStyle(fontSize: 25),
                  ),
                  child: Text("Buscar"),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('user')
                        .doc('YAOEiPFGf1dLiN3kXkob')
                        .set({'name': 'porfavorfunciona'});
                  } /*{
                    String origem = _partidaController.text;
                    String destino = "GRG - TODOS"; // Seu destino fixo
                    String data = _dateController.text;

                    if (origem.isNotEmpty && data.isNotEmpty) {
                      // Se ambos os campos não estiverem vazios, navegue para a próxima tela
                      Navigator.pushNamed(
                        context,
                        ResultadosBusca.routeName,
                        arguments: SearchArguments(origem, destino, data),
                      );
                      print('Origem $origem Data: $data');
                    } else {
                      // Caso contrário, exiba uma mensagem ao usuário
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Por favor, preencha todos os campos."),
                        ),
                      );
                    }
                  }*/
                  ,
                ),
              )
            ],
          ),
        ),
      ),
      /*ListView(children: [
          //aqui começam as coisas na tela, os buscadores e a imagem
          Stack(children: [
            Padding(
                padding: EdgeInsets.only(
                    top: 45,
                    left: 35,
                    right:
                        35), //valores precisam ser atualizados pra ficar em função da tela
                child: SearchBar(
                  //aqui é a primeira SearchBar, a de local de partida
                  textStyle: MaterialStateProperty.all(TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
                  leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu)), //icone da esquerda
                  hintText: "Local de Partida",
                  hintStyle: MaterialStateProperty.all(TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(165, 0, 79, 121)),
                  trailing: [
                    //icone da direita
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    )
                  ],
                )),
            Padding(
                //imagem do mapa
                padding: EdgeInsets.only(
                    top: 95,
                    left: 35,
                    right:
                        35), //valores precisam ser atualizados pra ficar em função da tela
                child: Image.asset(
                  'images/ImagemMapa.png',
                  height:
                      200, //valores precisam ser atualizados pra ficar em função da tela
                  alignment: Alignment.center,
                )),
            Padding(
                //mais uma search bar, essa é a de destino
                padding: EdgeInsets.only(
                    top: 275,
                    left: 35,
                    right:
                        35), //valores precisam ser atualizados pra ficar em função da tela
                child: SearchBar(
                  textStyle: MaterialStateProperty.all(TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(165, 0, 79, 121)),
                  leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu)), //icone da esquerda
                  hintText: "Destino",
                  hintStyle: MaterialStateProperty.all(TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
                  trailing: [
                    //icone da direita
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    )
                  ],
                )),
            Padding(
                //bloco de data
                padding: EdgeInsets.only(top: 345, left: 45, right: 45),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller:
                      _dateController, //chamar o controller de data pra atualizar o texto
                  decoration: InputDecoration(
                    labelText: 'Data',
                    filled: true,
                    fillColor: Color.fromARGB(255, 205, 203, 203),
                    suffixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 71, 159))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 71, 159))),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(); //chama a função de seleção de data(tá no final do codigo)
                  },
                )),
            Padding(
                //bloco de hora
                padding: EdgeInsets.only(top: 445, left: 45, right: 45),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller:
                      _hourController, //chama o controller de hora pra atualizar o texto
                  decoration: InputDecoration(
                    labelText: 'Hora',
                    filled: true,
                    fillColor: Color.fromARGB(255, 205, 203, 203),
                    suffixIcon: Icon(Icons.timer),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 71, 159))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 71, 159))),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectTime(); //chama a função de selecionar hora quando clicado
                  },
                )),
            Padding(
                //Botão de "Buscar" no fim da tela
                padding: EdgeInsets.only(
                    top: 545,
                    left: 130,
                    right:
                        45), //valores precisam ser atualizados pra ficar em função da tela
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 71, 159),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        minimumSize: Size(15, 45),
                        textStyle: TextStyle(fontSize: 25)),
                    child: Text("Buscar"),
                    onPressed: () => ()))
          ]),
        ]),*/
      bottomNavigationBar: CustomBottomNavigationBar(role: 'passageiro'),
    );
  }

  Future<void> _selectDate() async {
    //função de seleção de data
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime
            .now(), //pega a data inicial, ou seja, o dia mais antigo que pode ser selecionado. Botei o dia atual, sempre
        firstDate: DateTime
            .now(), //a primeira data selecionável também é sempre o dia atual, pra ninguém pedir carona ontem
        lastDate: DateTime(
            2100)); //Botei 2100 como a ultima data selecionável, mas queria uma forma de fixar no maximo x dias à frente

    if (_picked != null) {
      //quando é selecionado algo diferente de null, coloca o texto da data no controller pra ir pro bloco de texto la em cima.
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime() async {
    //função de seleção de hora
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_picked != null) {
      //quando é selecionado algo diferente de null, coloca o texto da hora no controller pra ir pro bloco de texto la em cima.
      setState(() {
        _hourSelect = _picked;
        _hourController.text =
            "${_hourSelect.hour}:${_hourSelect.minute}"; //a diferença aqui é que precisei pegar parcialmente, se não a formatação ficaria estranha. Mas nem se preocupa
      });
    }
  }
}
