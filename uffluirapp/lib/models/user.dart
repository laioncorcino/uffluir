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
