import 'package:floor/floor.dart';
import 'package:lz_flutter_app/network/domains/simple_http_request.dart';
import 'package:lz_flutter_app/network/repositories/simple_http_request_local_repository.dart';


part 'my_floor_dataBase.g.dart';

@Database(version: 1, entities: [SimpleHttpRequest])
abstract class MyFloorDatabase extends FloorDatabase {
  SimpleHttpRequestLocalRepository get httpRequestLocalRepository;
}
