import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late GetStorage storage;
  Future<StorageService> init() async {
    await GetStorage.init();
     storage = GetStorage();
    return this;
  }
void write(String key, dynamic value) => storage.write(key, value);
dynamic read(String key) => storage.read(key);
void remove(String key) => storage.remove(key);
}
