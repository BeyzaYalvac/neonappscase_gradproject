import 'package:equatable/equatable.dart';
import 'dart:math' as math;

class AccountModel extends Equatable {
  final int storageLeft;
  final int premiumTrafficLeft;
  final String email;
  final String premiumExpire;
  final String balance;
  final int trafficUsed;
  final String trafficLeft;
  final int storageUsed;

  const AccountModel({
    required this.storageLeft,
    required this.premiumTrafficLeft,
    required this.email,
    required this.premiumExpire,
    required this.balance,
    required this.trafficUsed,
    required this.trafficLeft,
    required this.storageUsed,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    final result = map['result'] ?? map;

    int toInt(dynamic v) => int.tryParse(v?.toString() ?? '') ?? 0;

    return AccountModel(
      storageLeft: toInt(result['storage_left']),
      premiumTrafficLeft: toInt(result['premium_traffic_left']),
      email: result['email']?.toString() ?? '',
      premiumExpire: result['premium_expire']?.toString() ?? '',
      balance: result['balance']?.toString() ?? '',
      trafficUsed: toInt(result['traffic_used']),
      trafficLeft: result['traffic_left']?.toString() ?? '',
      storageUsed: toInt(result['storage_used']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storage_left': storageLeft,
      'premium_traffic_left': premiumTrafficLeft,
      'email': email,
      'premium_expire': premiumExpire,
      'balance': balance,
      'traffic_used': trafficUsed,
      'traffic_left': trafficLeft,
      'storage_used': storageUsed,
    };
  }

  /// Helper: Byte -> okunabilir string (ör. "1.2 GB")
  static String formatBytes(num bytes, [int decimals = 1]) {
    if (bytes <= 0) return "0 B";
    const k = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (math.log(bytes) / math.log(k)).floor();
    final v = bytes / math.pow(k, i);
    return "${v.toStringAsFixed(decimals)} ${sizes[i]}";
  }

  /// Kullanım kolaylığı için computed alanlar:
  String get storageUsedFormatted => formatBytes(storageUsed);
  String get storageLeftFormatted => formatBytes(storageLeft);
  String get trafficUsedFormatted => formatBytes(trafficUsed);
  String get trafficLeftFormatted => formatBytes(trafficLeft as num);

  @override
  List<Object?> get props => [
    storageLeft,
    premiumTrafficLeft,
    email,
    premiumExpire,
    balance,
    trafficUsed,
    trafficLeft,
    storageUsed,
  ];
}
