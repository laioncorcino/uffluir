import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String id;
  String cnh;
  String email;
  String nome;
  int score;
  String photoUrl;

  UserModel({
    required this.id,
    required this.cnh,
    required this.email,
    required this.nome,
    required this.score,
    required this.photoUrl,
  });

  // Factory method to create a UserModel from Firestore document
  factory UserModel.fromFirestore(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      cnh: data['cnh'] ?? "",
      email: data['email'] ?? "",
      nome: data['nome'] ?? "",
      score: data['score'] ?? 0,
      photoUrl: data['photoUrl'] ?? "",
    );
  }

  // Method to convert UserModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'cnh': cnh,
      'email': email,
      'nome': nome,
      'score': score,
      'photoUrl': photoUrl,
    };
  }
}

UserModel UserModelFirebase(DocumentSnapshot user) {
  return UserModel(
    id: user.id,
    cnh: user.data.toString().contains('cnh') ? user.get('cnh') : '',
    email: user.data.toString().contains('email') ? user.get('email') : '',
    nome: user.data.toString().contains('nome') ? user.get('nome') : '',
    score: user.data.toString().contains('score') ? user.get('score') : 0,
    photoUrl:
        user.data.toString().contains('photoUrl') ? user.get('photoUrl') : '',
  );
}

Future<UserModel?> obtemInfoUsuario(String? uid) async {
  DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('user').doc(uid).get();

  UserModel user = UserModelFirebase(userDoc);
  return user;
}
