import 'package:inject/inject.dart';

import 'my_floor_database.dart';

@singleton
@provide
class AppDataBase    {

  MyFloorDatabase db;

  Future<void> init() async =>
    db = await $FloorMyFloorDatabase.databaseBuilder("app_database.db").build();


}
