import 'package:chopper/chopper.dart';
import 'dart:convert';


class JsonToTypeConverter extends JsonConverter {

  final Map<Type, Function> typeToJsonFactoryMap;
  final Function defaultTypeFactory;

  JsonToTypeConverter(this.typeToJsonFactoryMap,{this.defaultTypeFactory});

  @override
  Response convertError<BodyType, InnerType>(Response response) {
    if ((response.body as String).isEmpty) {
      return response;
    }
    var jsonMap = json.decode(response.body);
    if(typeToJsonFactoryMap[InnerType] == null){
      return response.replace(
          body:defaultTypeFactory(jsonMap));
    }
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

  T fromJsonData<T, InnerType>(dynamic jsonData, Function jsonParser) {
    dynamic jsonMap;
    try{
      jsonMap = json.decode(jsonData);
    }catch(e){
      return jsonData as T;
    }


    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}