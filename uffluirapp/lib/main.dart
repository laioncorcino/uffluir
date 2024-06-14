import 'package:flutter/material.dart';
import 'package:uffluir/firebase_options.dart';
import 'package:uffluir/models/user.dart';
import 'package:uffluir/pages/login.dart';
import 'pages/home.dart';
import 'pages/support.dart';
import 'pages/perfil.dart';
import 'pages/minhasCaronas.dart';
import 'pages/detalhes.dart';
import 'pages/homeMoto.dart';
import 'pages/supportMoto.dart';
import 'pages/perfilMoto.dart';
import 'pages/resultadosBusca.dart';
import 'package:firebase_core/firebase_core.dart';

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
          Home.routeName: (context) => Home(),
          HomeMoto.routeName: (context) => HomeMoto(),
          Support.routeName: (context) => Support(),
          SupportMoto.routeName: (context) => SupportMoto(),
          Perfil.routeName: (context) => Perfil(),
          PerfilMoto.routeName: (context) => PerfilMoto(),
          MinhasCaronas.routeName: (context) => MinhasCaronas(),
          Detalhes.routeName: (context) => Detalhes(),
          Login.routeName: (context) => Login(),
          //ResultadosBusca.routeName: (context) => ResultadosBusca()
        },
        /*onGenerateRoute: (settings) {
          // Verifica a rota sendo chamada
          if (settings.name == Home.routeName) {
            // Verifica os argumentos passados para a rota
            final args = settings.arguments as UserModel;

            // Retorna uma nova página Home com o UserModel como parâmetro
            return MaterialPageRoute(
              builder: (context) {
                return Home(userModel: args);
              },
            );
          }
          // Retorna null para rotas não reconhecidas
          return null;
        },*/
        title: "Navegação",
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
