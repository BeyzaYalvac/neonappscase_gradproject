import 'package:equatable/equatable.dart';

class UploadServerModel extends Equatable {
  final String msg;
  final String serverTime;
  final int status;
  final String sessId;
  final String result; // upload için kullanılacak URL

  const UploadServerModel({
    required this.msg,
    required this.serverTime,
    required this.status,
    required this.sessId,
    required this.result,
  });

  factory UploadServerModel.fromMap(Map<String, dynamic> map) {
    return UploadServerModel(
      msg: map['msg']?.toString() ?? '',
      serverTime: map['server_time']?.toString() ?? '',
      status: map['status'] is int
          ? map['status']
          : int.tryParse(map['status'].toString()) ?? 0,
      sessId: map['sess_id']?.toString() ?? '',
      result: map['result']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'server_time': serverTime,
      'status': status,
      'sess_id': sessId,
      'result': result,
    };
  }

  @override
  List<Object?> get props => [msg, serverTime, status, sessId, result];
}
