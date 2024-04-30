import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/support.dart';
import 'pages/perfil.dart';
import 'pages/minhasCaronas.dart';

void main() {
  runApp(MaterialApp(
      //da pra usar o comentado abaixo como referência pra fazer as telas
      initialRoute: "/",
      routes: {
        "/home": (context) => const Home(),
        "/support": (context) => const Support(),
        "/perfil": (context) => const Perfil(),
        "/minhasCaronas": (context) => const MinhasCaronas(),
      },
      title: "Navegação",
      debugShowCheckedModeBanner: false,
      home: Home()));
}
