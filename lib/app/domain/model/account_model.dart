// account_model.dart
import 'dart:convert';
import 'package:equatable/equatable.dart';

int _asInt(dynamic v, {int fallback = 0}) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

String _asStr(dynamic v, {String fallback = ''}) {
  if (v is String) return v;
  if (v == null) return fallback;
  return v.toString();
}

Map<String, dynamic> _asMap(dynamic v) =>
    (v is Map) ? v.map((k, v) => MapEntry('$k', v)) : <String, dynamic>{};

class AccountModel extends Equatable {
  final IpTraffic ipTraffic;
  final String id;
  final int createTime; // epoch seconds
  final String email;
  final String tier;
  final String token;
  final String rootFolder;
  final StatsCurrent statsCurrent;
  final IpInfo ipinfo;

  const AccountModel({
    required this.ipTraffic,
    required this.id,
    required this.createTime,
    required this.email,
    required this.tier,
    required this.token,
    required this.rootFolder,
    required this.statsCurrent,
    required this.ipinfo,
  });

  DateTime get createdAtUtc =>
      DateTime.fromMillisecondsSinceEpoch(createTime * 1000, isUtc: true);

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    // Bazı API'lar {status, data:{...}} döner; dışarıda unwrap ettiysen gereksiz.
    final core = (map['data'] is Map<String, dynamic>)
        ? map['data'] as Map<String, dynamic>
        : map;

    return AccountModel(
      ipTraffic: IpTraffic.fromMap(_asMap(core['ipTraffic'])),
      id: _asStr(core['id']),
      createTime: _asInt(core['createTime']),
      email: _asStr(core['email']),
      tier: _asStr(core['tier']),
      token: _asStr(core['token']),
      rootFolder: _asStr(core['rootFolder']),
      statsCurrent: StatsCurrent.fromMap(_asMap(core['statsCurrent'])),
      ipinfo: IpInfo.fromMap(_asMap(core['ipinfo'])),
    );
  }

  Map<String, dynamic> toMap() => {
    'ipTraffic': ipTraffic.toMap(),
    'id': id,
    'createTime': createTime,
    'email': email,
    'tier': tier,
    'token': token,
    'rootFolder': rootFolder,
    'statsCurrent': statsCurrent.toMap(),
    'ipinfo': ipinfo.toMap(),
  };

  factory AccountModel.fromJson(String s) =>
      AccountModel.fromMap(json.decode(s) as Map<String, dynamic>);
  String toJson() => json.encode(toMap());

  AccountModel copyWith({
    IpTraffic? ipTraffic,
    String? id,
    int? createTime,
    String? email,
    String? tier,
    String? token,
    String? rootFolder,
    StatsCurrent? statsCurrent,
    IpInfo? ipinfo,
  }) {
    return AccountModel(
      ipTraffic: ipTraffic ?? this.ipTraffic,
      id: id ?? this.id,
      createTime: createTime ?? this.createTime,
      email: email ?? this.email,
      tier: tier ?? this.tier,
      token: token ?? this.token,
      rootFolder: rootFolder ?? this.rootFolder,
      statsCurrent: statsCurrent ?? this.statsCurrent,
      ipinfo: ipinfo ?? this.ipinfo,
    );
  }

  @override
  List<Object?> get props => [
    id,
    createTime,
    email,
    tier,
    token,
    rootFolder,
    statsCurrent,
    ipinfo,
    ipTraffic,
  ];
}

/// YIL -> AY -> GÜN -> DEĞER
class IpTraffic extends Equatable {
  final Map<int, Map<int, Map<int, int>>> years;

  const IpTraffic({required this.years});

  factory IpTraffic.fromMap(Map<String, dynamic> map) {
    final out = <int, Map<int, Map<int, int>>>{};

    map.forEach((yearStr, monthsAny) {
      final y = int.tryParse('$yearStr');
      if (y == null) return;

      final monthsMap = <int, Map<int, int>>{};
      if (monthsAny is Map) {
        monthsAny.forEach((monthStr, daysAny) {
          final m = int.tryParse('$monthStr');
          if (m == null) return;

          final daysMap = <int, int>{};
          if (daysAny is Map) {
            daysAny.forEach((dayStr, valAny) {
              final d = int.tryParse('$dayStr');
              final v = (valAny is num)
                  ? valAny.toInt()
                  : int.tryParse('$valAny') ?? 0;
              if (d != null) daysMap[d] = v;
            });
          }
          monthsMap[m] = daysMap;
        });
      }
      out[y] = monthsMap;
    });

    return IpTraffic(years: out);
  }

  Map<String, dynamic> toMap() {
    final out = <String, dynamic>{};
    years.forEach((y, months) {
      final monthsOut = <String, dynamic>{};
      months.forEach((m, days) {
        final daysOut = <String, dynamic>{};
        days.forEach((d, v) => daysOut['$d'] = v);
        monthsOut['$m'] = daysOut;
      });
      out['$y'] = monthsOut;
    });
    return out;
  }

  int? getValue({required int year, required int month, required int day}) {
    return years[year]?[month]?[day];
  }

  @override
  List<Object?> get props => [years];
}

class StatsCurrent extends Equatable {
  final int folderCount;
  final int fileCount;
  final int storage; // bytes
  final int trafficWebDownloaded;

  const StatsCurrent({
    required this.folderCount,
    required this.fileCount,
    required this.storage,
    required this.trafficWebDownloaded,
  });

  factory StatsCurrent.fromMap(Map<String, dynamic> map) {
    return StatsCurrent(
      folderCount: _asInt(map['folderCount']),
      fileCount: _asInt(map['fileCount']),
      storage: _asInt(map['storage']),
      trafficWebDownloaded: _asInt(map['trafficWebDownloaded']),
    );
  }

  Map<String, dynamic> toMap() => {
    'folderCount': folderCount,
    'fileCount': fileCount,
    'storage': storage,
    'trafficWebDownloaded': trafficWebDownloaded,
  };

  @override
  List<Object?> get props => [
    folderCount,
    fileCount,
    storage,
    trafficWebDownloaded,
  ];
}

class IpInfo extends Equatable {
  final String id; // _id
  final String cidr;
  final String asnNumber; // örn: "AS47524"
  final String asnName;
  final String asnType; // isp/hosting/...
  final String country; // TR
  final String netblockId;
  final String netblockName;
  final int netblockSize; // bazen string gelebilir → _asInt
  final String netblockDomain;

  const IpInfo({
    required this.id,
    required this.cidr,
    required this.asnNumber,
    required this.asnName,
    required this.asnType,
    required this.country,
    required this.netblockId,
    required this.netblockName,
    required this.netblockSize,
    required this.netblockDomain,
  });

  factory IpInfo.fromMap(Map<String, dynamic> map) {
    return IpInfo(
      id: _asStr(map['_id']),
      cidr: _asStr(map['cidr']),
      asnNumber: _asStr(map['asnNumber']),
      asnName: _asStr(map['asnName']),
      asnType: _asStr(map['asnType']),
      country: _asStr(map['country']),
      netblockId: _asStr(map['netblockId']),
      netblockName: _asStr(map['netblockName']),
      netblockSize: _asInt(map['netblockSize']),
      netblockDomain: _asStr(map['netblockDomain']),
    );
  }

  Map<String, dynamic> toMap() => {
    '_id': id,
    'cidr': cidr,
    'asnNumber': asnNumber,
    'asnName': asnName,
    'asnType': asnType,
    'country': country,
    'netblockId': netblockId,
    'netblockName': netblockName,
    'netblockSize': netblockSize,
    'netblockDomain': netblockDomain,
  };

  @override
  List<Object?> get props => [
    id,
    cidr,
    asnNumber,
    asnName,
    asnType,
    country,
    netblockId,
    netblockName,
    netblockSize,
    netblockDomain,
  ];
}
