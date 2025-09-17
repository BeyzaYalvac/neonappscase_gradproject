import 'dart:convert';

import 'package:hive/hive.dart';

part 'hive_cache_model.g.dart';

@HiveType(typeId: 0)
class CacheModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String value;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final Duration maxAge;

  CacheModel({
    required this.key,
    required this.value,
    required this.createdAt,
    required this.maxAge,
  });

  bool get isFresh => DateTime.now().difference(createdAt) <= maxAge;

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
      'timestamp': createdAt.toIso8601String(),
      'maxAge': maxAge.inMinutes,
    };
  }

  factory CacheModel.fromMap(Map<String, dynamic> map) {
    return CacheModel(
      key: map['key'],
      value: map['value'],
      createdAt: DateTime.parse(map['timestamp']),
      maxAge: Duration(minutes: map['maxAge']),
    );
  }

  String toJson() => jsonEncode(toMap());
  factory CacheModel.fromJson(String s) =>
      CacheModel.fromMap(jsonDecode(s) as Map<String, dynamic>);
}
