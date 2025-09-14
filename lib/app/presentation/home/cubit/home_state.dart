import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final int selectedIndex;
  final Map<String, dynamic>? acountInfos;
  final double totalStorage;

  const HomeState({
    this.isLoading = false,
    this.isGridView = false,
    this.selectedIndex = 0,
    this.acountInfos,
    this.totalStorage = 100,
  });

  factory HomeState.initial() => const HomeState(acountInfos: {});

  HomeState copyWith({
    bool? isLoading,
    bool? isGridView,
    int? selectedIndex,
    Map<String, dynamic>? acountInfos,
    double? totalStorage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      acountInfos: acountInfos ?? this.acountInfos,
      totalStorage: totalStorage ?? this.totalStorage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isGridView, selectedIndex, acountInfos, totalStorage];

  @override
  String toString() =>
      'HomeState(isLoading: $isLoading, isGridView: $isGridView, selectedIndex: $selectedIndex, acountInfos: $acountInfos, totalStorage: $totalStorage)';
}
