import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/config/app_config.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container.dart';
import 'package:neonappscase_gradproject/app/domain/model/content_model.dart';

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

    const contentTypeId = 11; // ContentTypeAdapter().typeId
    const contentModelId = 12; // ContentModelAdapter().typeId

    if (!Hive.isAdapterRegistered(contentTypeId)) {
      Hive.registerAdapter(ContentTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(contentModelId)) {
      Hive.registerAdapter(ContentModelAdapter());
    }

    await Hive.openBox<ContentModel>('contentsBox');
    final settingsBox = await Hive.openBox('settingsBox');
    final dataBox = await Hive.openBox<String>('data_box');
    final firstControl = await Hive.openBox<bool>('first_control_box');
    if (!firstControl.containsKey(AppConfig.isFirstKey)) {
      await firstControl.put(AppConfig.isFirstKey, true);
    }
    return BootResult(settingsBox: settingsBox, dataBox: dataBox);
  }
}
