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
        Home.routeName: (context) => Home(),
        HomeMoto.routeName: (context) => HomeMoto(),
        Support.routeName: (context) => Support(),
        SupportMoto.routeName: (context) => SupportMoto(),
        Perfil.routeName: (context) => Perfil(),
        PerfilMoto.routeName: (context) => PerfilMoto(),
        MinhasCaronas.routeName: (context) => MinhasCaronas(),
        Detalhes.routeName: (context) => Detalhes(),
        ResultadosBusca.routeName: (context) => ResultadosBusca()
      },
      title: "Navegação",
      debugShowCheckedModeBanner: false,
      home: Home()));
}
