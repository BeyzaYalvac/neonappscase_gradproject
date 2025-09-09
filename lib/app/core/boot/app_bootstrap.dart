import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/core/injections/injection_container.dart';


class BootResult {
  final Box settingsBox;
  final Box<String> dataBox;
  BootResult({required this.settingsBox, required this.dataBox});
}

class AppBootstrap {
  static Future<BootResult> init() async {
    await dotenv.load(fileName: ".env");
    InjectionContainer.setUp();

    await Hive.initFlutter();
    const cacheTypeId =
        0; // CacheModelAdapter.typeId (senin adapter’in typeId’si) cacheTypeId hatası alıyorduk daha önce id ver.lmediğine emşn oldum
    if (!Hive.isAdapterRegistered(cacheTypeId)) {
      //Hive.registerAdapter(CacheModelAdapter());
    }
    final settingsBox = await Hive.openBox('settingsBox');
    final dataBox = await Hive.openBox<String>('data_box');

    return BootResult(settingsBox: settingsBox, dataBox: dataBox);
  }
}
