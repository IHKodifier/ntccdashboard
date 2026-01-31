import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/dashboard_provider.dart';
import 'widgets/violation_distribution_chart.dart';
import 'widgets/district_breakdown_list.dart';
import 'widgets/violation_heatmap_grid.dart';
import 'widgets/top_offenders_list.dart';

class ProvincialSummaryScreen extends ConsumerWidget {
  const ProvincialSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(ref, dashboardState),
          const SizedBox(height: 32),
          _buildFilterRow(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const ViolationDistributionChart(),
                    const SizedBox(height: 32),
                    ViolationHeatmapGrid(
                      onDistrictTap: (district) {
                        ref
                            .read(dashboardProvider.notifier)
                            .navigateToDistrict(district);
                      },
                    ),
                    const SizedBox(height: 32),
                    const TopOffendersList(),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: DistrictBreakdownList(
                  onDistrictTap: (district) {
                    ref
                        .read(dashboardProvider.notifier)
                        .navigateToDistrict(district);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(WidgetRef ref, DashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () =>
                  ref.read(dashboardProvider.notifier).navigateToNational(),
              child: const Text(
                'National Overview',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.textSecondary,
            ),
            Text(
              '${state.selectedProvince} Dashboard',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.selectedProvince} Dashboard: Violation Heatmap',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.sync, size: 14, color: AppColors.textSecondary),
                    SizedBox(width: 6),
                    Text(
                      'Last synced: 10 minutes ago',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                _buildActionButton(Icons.file_download_outlined, 'Export Data'),
                const SizedBox(width: 16),
                _buildPrimaryActionButton('Generate Report'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        _buildSmallFilter('Date: Last 30 Days', Icons.calendar_today_outlined),
        const SizedBox(width: 12),
        _buildSmallFilter('All Districts (36)', Icons.location_on_outlined),
        const SizedBox(width: 12),
        _buildSmallFilter(
          'Violation Type: All (8)',
          Icons.warning_amber_rounded,
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Clear All Filters',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallFilter(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryActionButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
