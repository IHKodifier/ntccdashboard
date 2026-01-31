import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants.dart';
import '../../core/dashboard_provider.dart';
import '../national/widgets/stats_card.dart';
import '../national/widgets/filter_bar.dart';
import '../national/widgets/provincial_performance_table.dart';
import '../national/widgets/active_alerts_list.dart';

class DistrictOverviewScreen extends ConsumerWidget {
  const DistrictOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final districtName = dashboardState.selectedDistrict ?? 'Province';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(districtName),
          const SizedBox(height: 32),
          const NationalFilterBar(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main content area
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const StatsCardGrid(),
                    const SizedBox(height: 32),
                    ProvincialPerformanceTable(
                      onProvinceTap: (entity) {
                        // District level - no further drill-down
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              // Sidebar content in the screen
              const Expanded(flex: 1, child: ActiveAlertsList()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(String districtName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$districtName Dashboard Overview',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'District monitoring of tobacco control efforts in $districtName',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildOutlinedButton(FontAwesomeIcons.calendarDay, 'FY 2023-24'),
            const SizedBox(width: 16),
            _buildExportButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildOutlinedButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          FaIcon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          FaIcon(FontAwesomeIcons.fileArrowDown, size: 16, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'Export Report',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
