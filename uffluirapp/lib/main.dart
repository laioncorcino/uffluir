import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/support.dart';
import 'pages/perfil.dart';
import 'pages/minhasCaronas.dart';
import 'pages/detalhes.dart';
import 'pages/homeMoto.dart';
import 'pages/supportMoto.dart';
import 'pages/perfilMoto.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext contexto) {
    return MaterialApp(
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
          //"/minhasCaronas": (context) => const MinhasCaronas()
        },
        title: "Navegação",
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
