import 'package:equatable/equatable.dart';

class FolderProcessModel extends Equatable {
  final String msg;
  final String serverTime;
  final int status;
  final String fldId;

  const FolderProcessModel({
    required this.msg,
    required this.serverTime,
    required this.status,
    required this.fldId,
  });

  factory FolderProcessModel.fromMap(Map<String, dynamic> map) {
    final result = (map['result'] is Map) ? map['result'] as Map : {};

    return FolderProcessModel(
      msg: map['msg']?.toString() ?? '',
      serverTime: map['server_time']?.toString() ?? '',
      status: map['status'] is int
          ? map['status']
          : int.tryParse(map['status'].toString()) ?? 0,
      fldId: result['fld_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'server_time': serverTime,
      'status': status,
      'result': {'fld_id': fldId},
    };
  }

  @override
  List<Object?> get props => [msg, serverTime, status, fldId];
}
