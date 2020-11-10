import 'package:chopper/chopper.dart';
import 'dart:convert';


class JsonToTypeConverter extends JsonConverter {

  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response convertError<BodyType, InnerType>(Response response) {
    if ((response.body as String).isEmpty) {
      return response;
    }
    var jsonMap = json.decode(response.body);
    return response.replace(
      body: typeToJsonFactoryMap[InnerType](jsonMap),
    );
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    if ((response.body as String).isEmpty) {
      return response;
    }
    return response.replace(
      body: fromJsonData<BodyType, InnerType>(response.body, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}