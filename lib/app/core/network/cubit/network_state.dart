import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

enum NetworkStatus { online, offline }

class NetworkState extends Equatable {
  final NetworkStatus status;
  final ConnectivityResult connectivity;

  const NetworkState({required this.status, required this.connectivity});

  factory NetworkState.initial() => const NetworkState(
        status: NetworkStatus.offline,
        connectivity: ConnectivityResult.none,
      );

  bool get isOnline => status == NetworkStatus.online;
  bool get isOffline => status == NetworkStatus.offline;

  NetworkState copyWith({
    NetworkStatus? status,
    ConnectivityResult? connectivity,
  }) {
    return NetworkState(
      status: status ?? this.status,
      connectivity: connectivity ?? this.connectivity,
    );
  }

  @override
  List<Object?> get props => [status, connectivity];
}
