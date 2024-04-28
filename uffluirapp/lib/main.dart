import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(MaterialApp(
      //da pra usar o comentado abaixo como referência pra fazer as telas
      initialRoute: "/",
      /*routes: {
        Tela2.routeName: (context) => Tela2(),
        "/tela3": (context) => Tela3()
      },
      onGenerateRoute: (settings) {
        if (settings.name == Tela2.routeName) {
          final args = settings.arguments as ScreenArguments;

          return MaterialPageRoute(
              builder: (context) => Tela2.arguments(args!.message));
        }
      },*/
      title: "Navegação",
      debugShowCheckedModeBanner: false,
      home: Home()));
}
