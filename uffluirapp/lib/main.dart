import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/support.dart';
import 'pages/perfil.dart';
import 'pages/minhasCaronas.dart';
import 'pages/detalhes.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: "/",
      routes: {
        "/home": (context) => const Home(),
        "/support": (context) => const Support(),
        "/perfil": (context) => const Perfil(),
        MinhasCaronas.routeName: (context) => MinhasCaronas(),
        Detalhes.routeName: (context) => Detalhes(),
        //"/minhasCaronas": (context) => const MinhasCaronas(),
      },
      title: "Navegação",
      debugShowCheckedModeBanner: false,
      home: Home()));
}
