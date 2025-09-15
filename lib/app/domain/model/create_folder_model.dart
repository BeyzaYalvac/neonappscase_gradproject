import 'package:equatable/equatable.dart';

class CreateFolderModel extends Equatable {
  final String msg;
  final String serverTime;
  final int status;
  final String fldId;

  const CreateFolderModel({
    required this.msg,
    required this.serverTime,
    required this.status,
    required this.fldId,
  });

  factory CreateFolderModel.fromMap(Map<String, dynamic> map) {
    final result = map['result'] ?? {};

    return CreateFolderModel(
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
      'result': {
        'fld_id': fldId,
      },
    };
  }

  @override
  List<Object?> get props => [msg, serverTime, status, fldId];
}
