import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants.dart';
import '../../../core/dashboard_provider.dart';

class NationalFilterBar extends ConsumerWidget {
  const NationalFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final dateFormat = DateFormat('E, d MMM yyyy');

    String dateRangeDisplay = 'Select Date Range';
    if (dashboardState.selectedDateRange != null) {
      dateRangeDisplay =
          '${dateFormat.format(dashboardState.selectedDateRange!.start)} - ${dateFormat.format(dashboardState.selectedDateRange!.end)}';
    } else {
      // Default mock display if none selected
      dateRangeDisplay = 'Mon, 1 Oct 2025 - Fri 31 Dec 2025';
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildFilterDropdown(
              'DATE RANGE',
              dateRangeDisplay,
              FontAwesomeIcons.calendarDays,
              () async {
                final range = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  initialDateRange: dashboardState.selectedDateRange,
                  builder: (context, child) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                          maxHeight: 600,
                        ),
                        child: Dialog(child: child),
                      ),
                    );
                  },
                );
                if (range != null) {
                  ref.read(dashboardProvider.notifier).updateDateRange(range);
                }
              },
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildFilterDropdown(
              'QUARTER',
              dashboardState.selectedQuarter,
              FontAwesomeIcons.chartSimple,
              () => _showSelectionDialog(
                context,
                'Select Quarter',
                ['Q1 2023', 'Q2 2023', 'Q3 2023', 'Q4 2023', 'Q1 2024'],
                (val) =>
                    ref.read(dashboardProvider.notifier).updateQuarter(val),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildFilterDropdown(
              'REGION/PROVINCE',
              dashboardState.selectedRegion,
              FontAwesomeIcons.mapLocationDot,
              () => _showSelectionDialog(
                context,
                'Select Region',
                [
                  'All Regions',
                  'Punjab',
                  'Sindh',
                  'Khyber Pakhtunkhwa',
                  'Balochistan',
                  'Gilgit-Baltistan',
                  'Azad Jammu & Kashmir',
                  'Islamabad Capital Territory',
                ],
                (val) => ref.read(dashboardProvider.notifier).updateRegion(val),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildFilterDropdown(
              'DISTRICT SELECTION',
              dashboardState.selectedFilterDistrict,
              FontAwesomeIcons.locationDot,
              () => _showSelectionDialog(
                context,
                'Select District',
                [
                  'All Districts',
                  'Lahore',
                  'Karachi',
                  'Peshawar',
                  'Quetta',
                  'Islamabad',
                  'Rawalpindi',
                  'Faisalabad',
                  'Multan',
                ],
                (val) =>
                    ref.read(dashboardProvider.notifier).updateDistrict(val),
              ),
            ),
          ),
          const SizedBox(width: 24),
          _buildApplyButton(ref, context),
        ],
      ),
    );
  }

  void _showSelectionDialog(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(options[index]),
                onTap: () {
                  onSelect(options[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  FaIcon(icon, size: 14, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton(WidgetRef ref, BuildContext context) {
    final isLoading = ref.watch(
      dashboardProvider.select((state) => state.isFilterLoading),
    );

    return Column(
      children: [
        const SizedBox(height: 20), // Alignment with dropdowns
        Material(
          color: AppColors.sidebar,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: isLoading
                ? null
                : () => ref.read(dashboardProvider.notifier).applyFilters(),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Apply Filters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
