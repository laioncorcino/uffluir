import 'package:uffluir/models/user.dart'; // Importe o modelo de usuário aqui

class UserModelSingleton {
  static final UserModelSingleton _instance = UserModelSingleton._internal();

  factory UserModelSingleton() {
    return _instance;
  }

  UserModelSingleton._internal();

  late UserModel _userModel;

  UserModel get userModel => _userModel;

  set userModel(UserModel user) {
    _userModel = user;
  }
}
