import 'package:hive/hive.dart';
import 'package:neonappscase_gradproject/app/common/cache/hive/hive_cache_operations.dart';
import 'package:neonappscase_gradproject/app/common/cache/hive_cache_model.dart';

class HiveCacheStore extends HiveCacheOperations {
  static const _boxName = 'data_box';
  Box<String> get _box => Hive.box<String>(_boxName);

  @override
  Future<void> write(CacheModel entry) async {
    await _box.put(entry.key, entry.toJson());
  }

  @override
  Future<CacheModel?> read(String key) async {
    final raw = _box.get(key);
    if (raw == null) return null;
    try {
      return CacheModel.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clear() => _box.clear();

  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }
}
