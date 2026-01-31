import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants.dart';
import '../../core/dashboard_provider.dart';

class DistrictModuleScreen extends ConsumerWidget {
  const DistrictModuleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final moduleName = _getModuleName(dashboardState.module);
    final moduleIcon = _getModuleIcon(dashboardState.module);

    return Container(
      color: const Color(0xFFF9FAFB),
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: FaIcon(moduleIcon, size: 64, color: AppColors.primary),
            ),
            const SizedBox(height: 32),
            Text(
              '${dashboardState.selectedDistrict} - $moduleName',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'District-level $moduleName screen',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.hammer,
                    size: 32,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Under Construction',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This district module screen is coming soon',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getModuleName(DashboardModule module) {
    switch (module) {
      case DashboardModule.overview:
        return 'Overview';
      case DashboardModule.compliance:
        return 'Compliance';
      case DashboardModule.violations:
        return 'Violations';
      case DashboardModule.retail:
        return 'Retail Enforcement';
      case DashboardModule.psv:
        return 'PSV Compliance';
      case DashboardModule.enforcement:
        return 'Enforcement Follow-up';
      case DashboardModule.reports:
        return 'Analytical Reports';
    }
  }

  IconData _getModuleIcon(DashboardModule module) {
    switch (module) {
      case DashboardModule.overview:
        return FontAwesomeIcons.gaugeHigh;
      case DashboardModule.compliance:
        return FontAwesomeIcons.shieldHalved;
      case DashboardModule.violations:
        return FontAwesomeIcons.triangleExclamation;
      case DashboardModule.retail:
        return FontAwesomeIcons.shop;
      case DashboardModule.psv:
        return FontAwesomeIcons.bus;
      case DashboardModule.enforcement:
        return FontAwesomeIcons.gavel;
      case DashboardModule.reports:
        return FontAwesomeIcons.fileLines;
    }
  }
}
