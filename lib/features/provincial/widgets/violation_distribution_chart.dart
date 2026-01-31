import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';

class ViolationDistributionChart extends StatelessWidget {
  const ViolationDistributionChart({super.key});

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
          const Text(
            'Violation Distribution',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 60,
                        sections: MockData.violationDistribution
                            .map(
                              (item) => PieChartSectionData(
                                value: item['value'],
                                color: item['color'],
                                radius: 25,
                                showTitle: false,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '2.4k',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'TOTAL',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem(
                      'No Signage (45%)',
                      const Color(0xFF3B82F6),
                    ),
                    _buildLegendItem(
                      'Public Smoking (20%)',
                      const Color(0xFF10B981),
                    ),
                    _buildLegendItem(
                      'Sale to Minors (15%)',
                      const Color(0xFFF59E0B),
                    ),
                    _buildLegendItem('Others (20%)', const Color(0xFFEF4444)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
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
}
