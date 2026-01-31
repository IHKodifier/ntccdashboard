import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants.dart';
import '../../core/dashboard_provider.dart';
import 'widgets/entity_stats_grid.dart';
import 'widgets/evidence_gallery.dart';
import 'widgets/inspection_history_table.dart';
import 'widgets/location_metadata_card.dart';

class DistrictEntityDetail extends ConsumerWidget {
  const DistrictEntityDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);

    return Container(
      color: Colors.black.withOpacity(0.05), // Light overlay feel as in design
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildModalHeader(context, ref, dashboardState),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      _buildEntityTitle(dashboardState),
                      const SizedBox(height: 32),
                      const EntityStatsGrid(),
                      const SizedBox(height: 48),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EvidenceGallery(),
                                SizedBox(height: 48),
                                InspectionHistoryTable(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),
                          const Expanded(
                            flex: 1,
                            child: LocationMetadataCard(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomActionToolbar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalHeader(
    BuildContext context,
    WidgetRef ref,
    DashboardState state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Row(
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 8),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 10,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              const Text(
                'District Enforcement',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 8),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 10,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                state.selectedDistrict ?? 'Entity',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildHeaderButton(FontAwesomeIcons.print, 'Print Summary'),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => ref
                .read(dashboardProvider.notifier)
                .navigateToProvincial(state.selectedProvince ?? 'Punjab'),
            icon: const FaIcon(FontAwesomeIcons.xmark, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF5F7FA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntityTitle(DashboardState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    state.selectedDistrict ?? 'Al-Noor Restaurant, Gulberg III',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'WARNING',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'License No: LHR-99283 | Last Inspected: 12 Oct 2023',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          FaIcon(icon, size: 14, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionToolbar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          _buildSecondaryButton('Seal Premises', AppColors.error, true),
          const SizedBox(width: 12),
          _buildSecondaryButton(
            'Issue Show Cause Notice',
            AppColors.warning,
            true,
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.sidebar,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Assign Field Staff',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(String label, Color color, bool outlined) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: outlined ? Border.all(color: color.withOpacity(0.3)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}
