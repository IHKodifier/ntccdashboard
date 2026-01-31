import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

enum DashboardLevel { national, provincial, district }

class DashboardState {
  final DashboardLevel currentLevel;
  final String? selectedProvince;
  final String? selectedDistrict;

  const DashboardState({
    this.currentLevel = DashboardLevel.national,
    this.selectedProvince,
    this.selectedDistrict,
  });

  DashboardState copyWith({
    DashboardLevel? currentLevel,
    String? selectedProvince,
    String? selectedDistrict,
  }) {
    return DashboardState(
      currentLevel: currentLevel ?? this.currentLevel,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }
}

@riverpod
class Dashboard extends _$Dashboard {
  @override
  DashboardState build() {
    return const DashboardState();
  }

  void navigateToNational() {
    state = const DashboardState(
      currentLevel: DashboardLevel.national,
      selectedProvince: null,
      selectedDistrict: null,
    );
  }

  void navigateToProvincial(String province) {
    state = state.copyWith(
      currentLevel: DashboardLevel.provincial,
      selectedProvince: province,
      selectedDistrict: null,
    );
  }

  void navigateToDistrict(String district) {
    state = state.copyWith(
      currentLevel: DashboardLevel.district,
      selectedDistrict: district,
    );
  }
}
