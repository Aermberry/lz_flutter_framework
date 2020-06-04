import 'package:inject/inject.dart';

@provide
class JsonConverter{

  JsonConverter();

  // e.g     {User: (jsonData) => User.fromJson(jsonData)};
  Map<Type, Function> getJsonConvert() => null;


}