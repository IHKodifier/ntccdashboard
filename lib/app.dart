import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants.dart';
import 'core/dashboard_provider.dart';
import 'features/national/national_overview_screen.dart';
import 'features/provincial/provincial_summary_screen.dart';
import 'features/district/district_entity_detail.dart';
import 'core/widgets/sidebar.dart';

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
          Sidebar(
            onOverviewTap: () =>
                ref.read(dashboardProvider.notifier).navigateToNational(),
          ),
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
                      _buildLevelIndicator(dashboardState),
                      const Spacer(),
                      // Action Icons
                      const _HeaderIcon(
                        icon: Icons.notifications_none_rounded,
                        hasBadge: true,
                      ),
                      const SizedBox(width: 16),
                      const _HeaderIcon(icon: Icons.settings_outlined),
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
                          backgroundImage: const NetworkImage(
                            AppConstants.userAvatar,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Area
                Expanded(
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
          const Icon(Icons.public, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(
            _getHeaderTitle(state),
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  String _getHeaderTitle(DashboardState state) {
    switch (state.currentLevel) {
      case DashboardLevel.national:
        return 'National Overview';
      case DashboardLevel.provincial:
        return '${state.selectedProvince} Overview';
      case DashboardLevel.district:
        return '${state.selectedDistrict} Detail';
    }
  }

  Widget _buildCurrentScreen(DashboardState state) {
    switch (state.currentLevel) {
      case DashboardLevel.national:
        return const NationalOverviewScreen();
      case DashboardLevel.provincial:
        return const ProvincialSummaryScreen();
      case DashboardLevel.district:
        return const DistrictEntityDetail();
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
