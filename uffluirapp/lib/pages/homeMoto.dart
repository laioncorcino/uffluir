import 'package:flutter/material.dart';
import 'dart:ui';
import 'screen_arguments.dart';
import 'support.dart';
import 'minhasCaronas.dart';
import 'perfil.dart';
import 'home.dart';
import 'supportMoto.dart';
import 'perfilMoto.dart';

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
  TextEditingController _hourController2 = TextEditingController();
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
                    child: SearchBar(
                      //aqui é a primeira SearchBar, a de local de partida
                      textStyle: MaterialStateProperty.all(TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20)),
                      leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu)), //icone da esquerda
                      hintText: "Local de Partida",
                      hintStyle: MaterialStateProperty.all(TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 237, 144, 49)),
                      trailing: [
                        //icone da direita
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        )
                      ],
                    )),
                Padding(
                    //mais uma search bar, essa é a de destino
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 35,
                        right:
                            35), //valores precisam ser atualizados pra ficar em função da tela
                    child: SearchBar(
                      textStyle: MaterialStateProperty.all(TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 237, 144, 49)),
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
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 35,
                        right:
                            35), //valores precisam ser atualizados pra ficar em função da tela
                    child: SearchBar(
                      //aqui é a primeira SearchBar, a de local de partida
                      textStyle: MaterialStateProperty.all(TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20)),
                      leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu)), //icone da esquerda
                      hintText: "Itinerário",
                      hintStyle: MaterialStateProperty.all(TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 237, 144, 49)),
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
                                    _hourController2, //chama o controller de hora pra atualizar o texto
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
                        onPressed: () => ()))
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
                  onPressed: () => {Navigator.pushNamed(context, '/homeMoto')},
                ), //
                label: 'Home'),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.help),
                onPressed: () => {Navigator.pushNamed(context, '/supportMoto')},
              ), //Icone de Suporte
              label: 'Suporte',

              //activeIcon: Support()
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.time_to_leave),
                onPressed: () =>
                    {Navigator.pushNamed(context, '/minhasCaronas')},
              ), //Icone de Carro no "Minhas Caronas"
              label: 'Minhas Caronas',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person),
                onPressed: () => {Navigator.pushNamed(context, '/perfilMoto')},
              ), //Icone Perfil
              label: 'Perfil',
            )
          ],
        ));
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
          _hourController2.text = "${_hourSelect.hour}:${_hourSelect.minute}";
        } //a diferença aqui é que precisei pegar parcialmente, se não a formatação ficaria estranha. Mas nem se preocupa
      });
    }
  }
}
