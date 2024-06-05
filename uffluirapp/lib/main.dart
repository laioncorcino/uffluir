import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/support.dart';
import 'pages/perfil.dart';
import 'pages/minhasCaronas.dart';
import 'pages/detalhes.dart';
import 'pages/homeMoto.dart';
import 'pages/supportMoto.dart';
import 'pages/perfilMoto.dart';
import 'pages/resultadosBusca.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: "/",
      routes: {
        "/home": (context) => const Home(),
        "/homeMoto": (context) => const HomeMoto(),
        "/support": (context) => const Support(),
        "/supportMoto": (context) => const SupportMoto(),
        "/perfil": (context) => const Perfil(),
        "/perfilMoto": (context) => const PerfilMoto(),
        MinhasCaronas.routeName: (context) => MinhasCaronas(),
        Detalhes.routeName: (context) => Detalhes(),
        ResultadosBusca.routeName: (context) => ResultadosBusca()
      },
      title: "Navegação",
      debugShowCheckedModeBanner: false,
      home: Home()));
}
