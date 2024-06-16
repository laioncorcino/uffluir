import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:uffluir/models/singletonUser.dart';
import 'package:uffluir/models/user.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:uffluir/pages/customBottonNavigationBar.dart';

class HomeMoto extends StatefulWidget {
  String message = "";
  static const String routeName = "/homeMoto";
  HomeMoto();

  @override
  State<HomeMoto> createState() => _HomeMotoState();
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class _HomeMotoState extends State<HomeMoto> {
  //controllers pro selecionador de data e hora
  TextEditingController _dateController = TextEditingController();
  TimeOfDay _hourSelect = TimeOfDay
      .now(); //esse aqui é pra ele "começar" na hora atual, explico la embaixo
  TextEditingController _hourController = TextEditingController();
  TextEditingController _hourControllerVolta = TextEditingController();
  final TextEditingController _partidaController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _trajetoController = TextEditingController();

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
  Widget build(BuildContext context) {
    final UserModel userModel = UserModelSingleton().userModel;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove o botão de voltar no topo
          //appbar, a faixa azul em cima. Essa parte você pode colar em outras telas e só mudar o "Buscar" pelo título da tela
          title: Row(children: [
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Ofertar",
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        )))),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              }, // Image tapped
              child: Image.asset(
                'images/motorista-icon.png',
                height: 40,
                alignment: Alignment.centerRight,
              ),
            ),
          ]),
          backgroundColor: Color.fromARGB(255, 153, 77, 0),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 35, left: 50, right: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(),
                            side: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 88, 88, 88),
                            ),
                            backgroundColor: Color.fromARGB(255, 213, 213, 212),
                            foregroundColor: Color.fromARGB(255, 2, 0, 0),
                            minimumSize: Size(350, 55),
                            textStyle: TextStyle(fontSize: 15)),
                        child: Text("Carro provisório"),
                        onPressed: () => ())),
                Padding(
                    //Botão de "Buscar" no fim da tela
                    padding: EdgeInsets.only(
                        top: 5,
                        left: 50,
                        right:
                            50), //valores precisam ser atualizados pra ficar em função da tela
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(),
                            side: BorderSide(
                              width: 0.5,
                              color: Color.fromARGB(255, 88, 88, 88),
                            ),
                            backgroundColor: Color.fromARGB(255, 213, 213, 212),
                            foregroundColor: Color.fromARGB(255, 2, 0, 0),
                            minimumSize: Size(350, 55),
                            textStyle: TextStyle(fontSize: 15)),
                        child: Text("Cadastrar Novo Veículo"),
                        onPressed: () => ())),
                Padding(
                    padding: EdgeInsets.only(
                        top: 20,
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
                              fillColor: Color.fromARGB(255, 237, 144, 49),
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
                              color: Color.fromARGB(
                                  255, 237, 144, 49), // Cor de fundo azul
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
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 35,
                        right:
                            35), //valores precisam ser atualizados pra ficar em função da tela
                    child: Column(
                      children: [
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            autofocus: true,
                            controller: _destinoController,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Local de Destino',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 237, 144, 49),
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
                              color: Color.fromARGB(
                                  255, 237, 144, 49), // Cor de fundo azul
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
                            _destinoController.text = suggestion;
                            print('Local selecionado: $suggestion');
                          },
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 35,
                        right:
                            35), //valores precisam ser atualizados pra ficar em função da tela
                    child: Column(
                      children: [
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            autofocus: true,
                            controller: _trajetoController,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Local Intermediário',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 237, 144, 49),
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
                              color: Color.fromARGB(
                                  255, 237, 144, 49), // Cor de fundo azul
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
                            _trajetoController.text = suggestion;
                            print('Local selecionado: $suggestion');
                          },
                        ),
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
                                color: Color.fromARGB(255, 237, 144, 49))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 237, 144, 49))),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(); //chama a função de seleção de data(tá no final do codigo)
                      },
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              //bloco de hora
                              padding:
                                  EdgeInsets.only(top: 20, right: 10, left: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                controller:
                                    _hourController, //chama o controller de hora pra atualizar o texto
                                decoration: InputDecoration(
                                  labelText: 'Hora Ida',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 205, 203, 203),
                                  suffixIcon: Icon(Icons.timer),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 237, 144, 49))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 237, 144, 49))),
                                ),
                                readOnly: true,
                                onTap: () {
                                  _selectTime(
                                      1); //chama a função de selecionar hora quando clicado
                                },
                              ))),
                      Expanded(
                          child: Padding(
                              //bloco de hora
                              padding:
                                  EdgeInsets.only(top: 20, right: 10, left: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                controller:
                                    _hourControllerVolta, //chama o controller de hora pra atualizar o texto
                                decoration: InputDecoration(
                                  labelText: 'Hora Volta (opcional)',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 205, 203, 203),
                                  suffixIcon: Icon(Icons.timer),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 237, 144, 49))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 237, 144, 49))),
                                ),
                                readOnly: true,
                                onTap: () {
                                  _selectTime(
                                      2); //chama a função de selecionar hora quando clicado
                                },
                              ))),
                    ]),
                Padding(
                    //Botão de "Buscar" no fim da tela
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 35,
                        right:
                            35), //valores precisam ser atualizados pra ficar em função da tela
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 153, 77, 0),
                            foregroundColor: Color.fromARGB(255, 255, 255, 255),
                            minimumSize: Size(150, 45),
                            textStyle: TextStyle(fontSize: 25)),
                        child: Text("Ofertar Carona"),
                        onPressed: () => {
                              FirebaseFirestore.instance
                                  .collection('ride')
                                  .add({
                                'name': userModel.nome,
                                'arrival_date': _dateController.text,
                                'arrival_place': _destinoController.text,
                                'return_time': _hourControllerVolta.text,
                                'departure_date': _dateController.text,
                                'departure_place': _partidaController.text,
                                'departure_time': _hourController.text,
                                'scheduled_stop': _trajetoController.text,
                                'size': 3,
                                'status': "ABERTO",
                                'rider_id': userModel.id
                              })
                            }))
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(role: 'motorista'));
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

  Future<void> _selectTime(a) async {
    //função de seleção de hora
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_picked != null) {
      //quando é selecionado algo diferente de null, coloca o texto da hora no controller pra ir pro bloco de texto la em cima.
      setState(() {
        _hourSelect = _picked;
        if (a == 1) {
          _hourController.text = "${_hourSelect.hour}:${_hourSelect.minute}";
        } else {
          _hourControllerVolta.text =
              "${_hourSelect.hour}:${_hourSelect.minute}";
        } //a diferença aqui é que precisei pegar parcialmente, se não a formatação ficaria estranha. Mas nem se preocupa
      });
    }
  }
}
