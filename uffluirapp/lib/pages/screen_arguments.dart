import 'package:uffluir/models/singletonUser.dart';
import 'package:uffluir/models/user.dart';

class ScreenArguments {
  int id = -1;

  ScreenArguments(this.id);
}

class ScreenArgumentsPerfil {
  UserModel userModel;

  ScreenArgumentsPerfil(this.userModel);
}
