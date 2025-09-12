import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:neonappscase_gradproject/app/core/network/cubit/network_state.dart' as net;


class NetworkCubit extends Cubit<net.NetworkState> {
  final Connectivity _connectivity;
  final InternetConnection _checker;

  StreamSubscription? _connSub;
  StreamSubscription? _checkSub;

  NetworkCubit({Connectivity? connectivity, InternetConnection? checker})
      : _connectivity = connectivity ?? Connectivity(),
        _checker = checker ?? InternetConnection(),
        super(net.NetworkState.initial());

  ConnectivityResult _normalize(dynamic value) {
    if (value is ConnectivityResult) return value;
    if (value is List<ConnectivityResult>) {
      return value.isNotEmpty ? value.first : ConnectivityResult.none;
    }
    return ConnectivityResult.none;
  }

  Future<void> start() async {
    // 1) Başlangıç durumu
    final initialRaw = await _connectivity.checkConnectivity();
    final initial = _normalize(initialRaw);
    final online = await _checker.hasInternetAccess;

    emit(state.copyWith(
      connectivity: initial,
      status: online ? net.NetworkStatus.online : net.NetworkStatus.offline,
    ));

    // 2) Arayüz değişimini dinle (wifi/mobil/none)
    _connSub = _connectivity.onConnectivityChanged.listen((event) async {
      final result = _normalize(event);
      final online = await _checker.hasInternetAccess;
      emit(state.copyWith(
        connectivity: result,
        status: online ? net.NetworkStatus.online : net.NetworkStatus.offline,
      ));
    });

    // 3) Gerçek internet değişimini dinle
    _checkSub = _checker.onStatusChange.listen((status) {
      emit(state.copyWith(
        status: status == InternetStatus.connected
            ? net.NetworkStatus.online
            : net.NetworkStatus.offline,
      ));
    });
  }

  @override
  Future<void> close() async {
    await _connSub?.cancel();
    await _checkSub?.cancel();
    return super.close();
  }
}
