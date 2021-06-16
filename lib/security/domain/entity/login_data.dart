import 'package:lz_flutter_app/security/domain/entity/username.dart';
import 'package:lz_flutter_app/security/remote_persistencce/dto/login_request.dart';

import 'password.dart';

class LoginData{

  Password _password;
  Username _username;

  LoginData(this._username,this._password);

  void checkValid(){
    _username.check();
    _password.check();
  }

  LoginRequest toLoginRequest() => LoginRequest(_username.username,_password.password);

}