import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
   final storage =FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future<String?> readValue(String key)async{

    String? value=await storage.read(key: key,aOptions: _getAndroidOptions());
     return value;
  }
  Future<void> writeValue(String key,String value)async{
    await storage.write(key: key, value: value,aOptions: _getAndroidOptions());
  }
  Future<void> deleteValue(String key) async{
    await storage.delete(key: key,aOptions: _getAndroidOptions());
  }

  Future<void> deleteAll() async{
    await storage.deleteAll(aOptions: _getAndroidOptions());
  }
}

