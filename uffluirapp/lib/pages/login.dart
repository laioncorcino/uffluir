import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uffluir/models/singletonUser.dart';
import 'package:uffluir/models/user.dart';
import 'home.dart'; // Importe a página home

class Login extends StatefulWidget {
  String message = "";
  static const String routeName = "/login";
  Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
        if (_user != null) {
          _handleUserInFirestore(_user!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loginPage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _user != null ? _userInfo() : _googleSignInButton(),
      ),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (_user!.photoURL != null)
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_user!.photoURL!),
                ),
              ),
            ),
          Text(UserModelSingleton().userModel.email ?? ""),
          Text(UserModelSingleton().userModel.nome ?? ""),
          MaterialButton(
            color: Colors.red,
            child: const Text("Sign Out"),
            onPressed: () async {
              await _auth.signOut();
              setState(() {
                _user = null;
                /*Resolver isto depois
                UserModelSingleton().userModel =
                    UserModel(); // Limpa o Singleton*/
              });
            },
          )
        ],
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithPopup(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleUserInFirestore(User user) async {
    try {
      QuerySnapshot userQuery = await _firestore
          .collection('user')
          .where('email', isEqualTo: user.email!)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;
        setState(() {
          UserModelSingleton().userModel = UserModel.fromFirestore(
            userDoc.id,
            userDoc.data() as Map<String, dynamic>,
          );
        });
        print("User ID: ${userDoc.id}");
      } else {
        // Adicionar novo usuário ao Firestore
        UserModel newUser = UserModel(
          id: user.uid,
          cnh: "",
          email: user.email!,
          nome: user.displayName ?? "Usuário sem nome",
          score: 10,
          photoUrl: user.photoURL ?? "",
        );
        await _firestore
            .collection('user')
            .doc(newUser.id)
            .set(newUser.toFirestore());
        setState(() {
          UserModelSingleton().userModel = newUser;
        });
        print("Novo usuário adicionado ao Firestore com ID: ${newUser.id}");
      }

      // Navegar para a página home, passando o UserModel como parâmetro
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } catch (e) {
      print("Error fetching or adding user to Firestore: $e");
    }
  }
}
