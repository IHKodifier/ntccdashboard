import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class EntityStatsGrid extends StatelessWidget {
  const EntityStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _DetailStatCard(
            label: 'Total Inspections',
            value: '12',
            trend: '+20%',
            isGood: true,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _DetailStatCard(
            label: 'Last Violation Date',
            value: '12 Oct 2023',
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _DetailStatCard(
            label: 'Fine Amount Paid',
            value: 'PKR 45k',
            trend: '+5%',
            isGood: true,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _DetailStatCard(
            label: 'Risk Score',
            value: '7.2/10',
            trend: '-2%',
            isGood: true,
          ),
        ),
      ],
    );
  }
}

class _DetailStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? trend;
  final bool isGood;

  const _DetailStatCard({
    required this.label,
    required this.value,
    this.trend,
    this.isGood = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              if (trend != null) ...[
                const SizedBox(width: 8),
                Text(
                  trend!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isGood ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
