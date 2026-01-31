import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'core/constants.dart';
import 'core/dashboard_provider.dart';
import 'features/national/national_overview_screen.dart';
import 'features/national/national_compliance_screen.dart';
import 'features/national/national_violations_screen.dart';
import 'features/national/national_retail_screen.dart';
import 'features/national/national_psv_screen.dart';
import 'features/national/national_enforcement_screen.dart';
import 'features/national/national_reporting_screen.dart';
import 'features/provincial/provincial_overview_screen.dart';
import 'features/provincial/provincial_compliance_screen.dart';
import 'features/provincial/provincial_violations_screen.dart';
import 'features/provincial/provincial_retail_screen.dart';
import 'features/provincial/provincial_psv_screen.dart';
import 'features/provincial/provincial_enforcement_screen.dart';
import 'features/provincial/provincial_reports_screen.dart';
import 'features/district/district_overview_screen.dart';
import 'features/district/district_compliance_screen.dart';
import 'features/district/district_violations_screen.dart';
import 'features/district/district_retail_screen.dart';
import 'features/district/district_psv_screen.dart';
import 'features/district/district_enforcement_screen.dart';
import 'features/district/district_reports_screen.dart';
import 'core/widgets/sidebar.dart';
import 'core/widgets/role_switcher.dart';
import 'core/widgets/loading_shimmer.dart';

class NTCCDashboardApp extends StatelessWidget {
  const NTCCDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTCC Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const DashboardShell(),
    );
  }
}

class DashboardShell extends ConsumerWidget {
  const DashboardShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () => ref
                              .read(dashboardProvider.notifier)
                              .toggleSidebar(),
                          icon: FaIcon(
                            dashboardState.isSidebarCollapsed
                                ? FontAwesomeIcons.bars
                                : FontAwesomeIcons.barsStaggered,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          tooltip: 'Toggle Sidebar',
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildLevelIndicator(dashboardState),
                      const SizedBox(width: 16),
                      const RoleSwitcher(),
                      const Spacer(),
                      // Action Icons
                      const _HeaderIcon(
                        icon: FontAwesomeIcons.bell,
                        hasBadge: true,
                      ),
                      const SizedBox(width: 16),
                      const _HeaderIcon(icon: FontAwesomeIcons.gear),
                      const SizedBox(width: 32),
                      // Vertical Divider
                      Container(
                        width: 1,
                        height: 40,
                        color: const Color(0xFFEEEEEE),
                      ),
                      const SizedBox(width: 32),
                      // Profile
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            AppConstants.userName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Text(
                            AppConstants.userRole,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          backgroundImage: const AssetImage(
                            'assets/images/user_avatar.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Area
                Expanded(
                  child: LoadingShimmer(
                    isLoading: dashboardState.isRoleSwitching,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildCurrentScreen(dashboardState),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.02, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelIndicator(DashboardState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const FaIcon(
            FontAwesomeIcons.globe,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 10),
          Text(
            _getHeaderTitle(state),
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const FaIcon(
            FontAwesomeIcons.chevronDown,
            size: 14,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  String _getHeaderTitle(DashboardState state) {
    if (state.hierarchy == DashboardHierarchy.national) {
      switch (state.module) {
        case DashboardModule.overview:
          return 'National Overview';
        case DashboardModule.compliance:
          return 'Compliance Dashboard';
        case DashboardModule.violations:
          return 'Violation Monitoring';
        case DashboardModule.retail:
          return 'Retail Compliance';
        case DashboardModule.psv:
          return 'PSV Enforcement';
        case DashboardModule.enforcement:
          return 'Enforcement Tracking';
        case DashboardModule.reports:
          return 'Analytical Reports';
      }
    } else if (state.hierarchy == DashboardHierarchy.provincial) {
      return '${state.selectedProvince} Overview';
    } else {
      return '${state.selectedDistrict} Detail';
    }
  }

  Widget _buildCurrentScreen(DashboardState state) {
    if (state.hierarchy == DashboardHierarchy.national) {
      switch (state.module) {
        case DashboardModule.overview:
          return const NationalOverviewScreen();
        case DashboardModule.compliance:
          return const NationalComplianceScreen();
        case DashboardModule.violations:
          return const NationalViolationsScreen();
        case DashboardModule.retail:
          return const NationalRetailScreen();
        case DashboardModule.psv:
          return const NationalPSVScreen();
        case DashboardModule.enforcement:
          return const NationalEnforcementScreen();
        case DashboardModule.reports:
          return const NationalReportingScreen();
      }
    } else if (state.hierarchy == DashboardHierarchy.provincial) {
      switch (state.module) {
        case DashboardModule.overview:
          return const ProvincialOverviewScreen();
        case DashboardModule.compliance:
          return const ProvincialComplianceScreen();
        case DashboardModule.violations:
          return const ProvincialViolationsScreen();
        case DashboardModule.retail:
          return const ProvincialRetailScreen();
        case DashboardModule.psv:
          return const ProvincialPSVScreen();
        case DashboardModule.enforcement:
          return const ProvincialEnforcementScreen();
        case DashboardModule.reports:
          return const ProvincialReportsScreen();
      }
    } else {
      switch (state.module) {
        case DashboardModule.overview:
          return const DistrictOverviewScreen();
        case DashboardModule.compliance:
          return const DistrictComplianceScreen();
        case DashboardModule.violations:
          return const DistrictViolationsScreen();
        case DashboardModule.retail:
          return const DistrictRetailScreen();
        case DashboardModule.psv:
          return const DistrictPSVScreen();
        case DashboardModule.enforcement:
          return const DistrictEnforcementScreen();
        case DashboardModule.reports:
          return const DistrictReportsScreen();
      }
    }
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final bool hasBadge;

  const _HeaderIcon({required this.icon, this.hasBadge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 22, color: AppColors.textPrimary),
        ),
        if (hasBadge)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
