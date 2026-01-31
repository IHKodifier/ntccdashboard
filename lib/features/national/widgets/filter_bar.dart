import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class NationalFilterBar extends StatelessWidget {
  const NationalFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: _buildFilterDropdown(
              'DATE RANGE',
              'Oct 1, 2023 - Dec 31, 2023',
              Icons.calendar_today_outlined,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildFilterDropdown(
              'QUARTER',
              'Q4 2023',
              Icons.pie_chart_outline_rounded,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildFilterDropdown(
              'REGION/PROVINCE',
              'All Regions',
              Icons.map_outlined,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildFilterDropdown(
              'DISTRICT SELECTION',
              'All Districts',
              Icons.location_on_outlined,
            ),
          ),
          const SizedBox(width: 24),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, IconData icon) {
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return Column(
      children: [
        const SizedBox(height: 20), // Alignment with dropdowns
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.sidebar,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Apply Filters',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
