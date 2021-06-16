import 'package:lz_flutter_app/security/domain/entity/username.dart';
import 'package:lz_flutter_app/security/remote_persistencce/dto/login_request.dart';
import 'package:lz_flutter_app/security/remote_persistencce/dto/register_request.dart';

import 'password.dart';

class RegisterData{

  Password _password;
  Username _username;

  RegisterData(this._username,this._password);

  void checkValid(){
    _username.check();
    _password.check();
  }

  RegisterRequest toRegisterRequest() => RegisterRequest(_username.username,_password.password);

}