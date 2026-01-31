import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

enum DashboardHierarchy { national, provincial, district }

enum DashboardModule {
  overview,
  compliance,
  violations,
  retail,
  psv,
  enforcement,
  reports,
}

enum UserRole { national, provincial, district }

class DashboardState {
  final DashboardHierarchy hierarchy;
  final DashboardModule module;
  final String? selectedProvince;
  final String? selectedDistrict;
  final bool isSidebarCollapsed;
  final bool isFilterLoading;

  // Role-based access control
  final UserRole currentRole;
  final String? assignedProvince; // For provincial users
  final String? assignedDistrict; // For district users
  final bool isRoleSwitching; // Loading state for role changes

  // Advanced Filter state
  final DateTimeRange? selectedDateRange;
  final String selectedQuarter;
  final String selectedRegion;
  final String selectedFilterDistrict;

  const DashboardState({
    this.hierarchy = DashboardHierarchy.national,
    this.module = DashboardModule.overview,
    this.selectedProvince,
    this.selectedDistrict,
    this.isSidebarCollapsed = false,
    this.isFilterLoading = false,
    this.currentRole = UserRole.national,
    this.assignedProvince,
    this.assignedDistrict,
    this.isRoleSwitching = false,
    this.selectedDateRange,
    this.selectedQuarter = 'Q4 2023',
    this.selectedRegion = 'All Regions',
    this.selectedFilterDistrict = 'All Districts',
  });

  DashboardState copyWith({
    DashboardHierarchy? hierarchy,
    DashboardModule? module,
    String? selectedProvince,
    String? selectedDistrict,
    bool? isSidebarCollapsed,
    bool? isFilterLoading,
    UserRole? currentRole,
    String? assignedProvince,
    String? assignedDistrict,
    bool? isRoleSwitching,
    DateTimeRange? selectedDateRange,
    String? selectedQuarter,
    String? selectedRegion,
    String? selectedFilterDistrict,
  }) {
    return DashboardState(
      hierarchy: hierarchy ?? this.hierarchy,
      module: module ?? this.module,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      isSidebarCollapsed: isSidebarCollapsed ?? this.isSidebarCollapsed,
      isFilterLoading: isFilterLoading ?? this.isFilterLoading,
      currentRole: currentRole ?? this.currentRole,
      assignedProvince: assignedProvince ?? this.assignedProvince,
      assignedDistrict: assignedDistrict ?? this.assignedDistrict,
      isRoleSwitching: isRoleSwitching ?? this.isRoleSwitching,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      selectedQuarter: selectedQuarter ?? this.selectedQuarter,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedFilterDistrict:
          selectedFilterDistrict ?? this.selectedFilterDistrict,
    );
  }
}

@riverpod
class Dashboard extends _$Dashboard {
  @override
  DashboardState build() {
    return DashboardState(
      selectedDateRange: DateTimeRange(
        start: DateTime(2025, 10, 1),
        end: DateTime(2025, 12, 31),
      ),
    );
  }

  void toggleSidebar() {
    state = state.copyWith(isSidebarCollapsed: !state.isSidebarCollapsed);
  }

  void updateDateRange(DateTimeRange range) {
    state = state.copyWith(selectedDateRange: range);
  }

  void updateQuarter(String quarter) {
    state = state.copyWith(selectedQuarter: quarter);
  }

  void updateRegion(String region) {
    state = state.copyWith(selectedRegion: region);
  }

  void updateDistrict(String district) {
    state = state.copyWith(selectedFilterDistrict: district);
  }

  Future<void> applyFilters() async {
    state = state.copyWith(isFilterLoading: true);
    // Simulate loading
    await Future.delayed(const Duration(milliseconds: 1500));
    state = state.copyWith(isFilterLoading: false);
  }

  // --- Role Management ---

  Future<void> switchToNationalUser() async {
    state = state.copyWith(isRoleSwitching: true);

    // Simulate data loading
    await Future.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      currentRole: UserRole.national,
      assignedProvince: null,
      assignedDistrict: null,
      hierarchy: DashboardHierarchy.national,
      selectedProvince: null,
      selectedDistrict: null,
      module: DashboardModule.overview,
      isRoleSwitching: false,
    );
  }

  Future<void> switchToProvincialUser(String province) async {
    state = state.copyWith(isRoleSwitching: true);

    // Simulate data loading
    await Future.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      currentRole: UserRole.provincial,
      assignedProvince: province,
      assignedDistrict: null,
      hierarchy: DashboardHierarchy.provincial,
      selectedProvince: province,
      selectedDistrict: null,
      module: DashboardModule.overview,
      isRoleSwitching: false,
    );
  }

  Future<void> switchToDistrictUser(String province, String district) async {
    state = state.copyWith(isRoleSwitching: true);

    // Simulate data loading
    await Future.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      currentRole: UserRole.district,
      assignedProvince: province,
      assignedDistrict: district,
      hierarchy: DashboardHierarchy.district,
      selectedProvince: province,
      selectedDistrict: district,
      module: DashboardModule.overview,
      isRoleSwitching: false,
    );
  }

  // --- Hierarchy Changes ---

  void navigateToNational() {
    // Only allow if user has national role
    if (state.currentRole != UserRole.national) {
      return;
    }

    state = state.copyWith(
      hierarchy: DashboardHierarchy.national,
      selectedProvince: null,
      selectedDistrict: null,
      module: DashboardModule.overview,
    );
  }

  void navigateToProvincial(String province) {
    // Provincial users can only navigate to their assigned province
    if (state.currentRole == UserRole.provincial &&
        province != state.assignedProvince) {
      return;
    }
    // District users cannot navigate to provincial level
    if (state.currentRole == UserRole.district) {
      return;
    }

    state = state.copyWith(
      hierarchy: DashboardHierarchy.provincial,
      selectedProvince: province,
      selectedDistrict: null,
      module: DashboardModule.overview,
    );
  }

  void navigateToDistrict(String district) {
    // District users can only navigate to their assigned district
    if (state.currentRole == UserRole.district &&
        district != state.assignedDistrict) {
      return;
    }

    state = state.copyWith(
      hierarchy: DashboardHierarchy.district,
      selectedDistrict: district,
      module: DashboardModule.overview,
    );
  }

  // --- Module Changes ---

  void setModule(DashboardModule module) {
    state = state.copyWith(module: module);
  }

  void navigateToCompliance() => setModule(DashboardModule.compliance);
  void navigateToViolations() => setModule(DashboardModule.violations);
  void navigateToRetail() => setModule(DashboardModule.retail);
  void navigateToPSV() => setModule(DashboardModule.psv);
  void navigateToEnforcement() => setModule(DashboardModule.enforcement);
  void navigateToReports() => setModule(DashboardModule.reports);
}
