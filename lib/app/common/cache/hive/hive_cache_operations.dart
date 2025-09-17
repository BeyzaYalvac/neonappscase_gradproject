
import 'package:neonappscase_gradproject/app/common/cache/hive_cache_model.dart';

abstract class HiveCacheOperations {
  Future<void> read(String key);
  Future<void> write(CacheModel cacheModel);
  Future<void> remove(String key);
  Future<void> clear();
}