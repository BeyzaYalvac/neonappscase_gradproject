import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/cache/hive_cache_model.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container.dart';

class BootResult {
  final Box settingsBox;
  final Box<String> dataBox;
  BootResult({required this.settingsBox, required this.dataBox});
}

class AppBootstrap {
  static Future<BootResult> init() async {
    await dotenv.load(fileName: ".env");

    await Hive.initFlutter();
    const cacheTypeId =
        0; 
    if (!Hive.isAdapterRegistered(cacheTypeId)) { //Typeid'lerin çakışmaması kontrolünü yapıyorum
      Hive.registerAdapter(CacheModelAdapter()); 
    }

    //Boxes
    final favoriteBox = await Hive.openBox('favorite_box');
    final settingsBox = await Hive.openBox('settingsBox');
    final dataBox = await Hive.openBox<String>('data_box');
    final firstControl = await Hive.openBox<bool>('first_control_box');

    if (!firstControl.containsKey(AppConfig.isFirstKey)) {
      await firstControl.put(AppConfig.isFirstKey, true);
    }

    InjectionContainer.setUp();

    return BootResult(settingsBox: settingsBox, dataBox: dataBox);
  }
}
