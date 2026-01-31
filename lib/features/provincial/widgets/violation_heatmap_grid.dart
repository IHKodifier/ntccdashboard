import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';

class ViolationHeatmapGrid extends StatelessWidget {
  final Function(String) onDistrictTap;

  const ViolationHeatmapGrid({super.key, required this.onDistrictTap});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'District Violation Heatmap',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Intensity represents violation frequency per category',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              _buildIntensityScale(),
            ],
          ),
          const SizedBox(height: 32),
          _buildHeatmapTable(),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Showing top districts. Use filters to view specific regions.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntensityScale() {
    return Row(
      children: [
        const Text(
          'INTENSITY SCALE:',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: List.generate(
            5,
            (index) => Container(
              width: 20,
              height: 14,
              color: AppColors.error.withOpacity(0.2 + (index * 0.2)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeatmapTable() {
    final types = MockData.heatmapTypes;
    final data = MockData.heatmapData;

    return Table(
      border: TableBorder.all(color: const Color(0xFFEEEEEE), width: 1),
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
          children: [
            const _TableCell('DISTRICT \ TYPE', isHeader: true),
            ...types.map((t) => _TableCell(t, isHeader: true)),
          ],
        ),
        ...data.entries.map(
          (entry) => TableRow(
            children: [
              _TableCell(
                entry.key,
                isHeader: true,
                onTap: () => onDistrictTap(entry.key),
              ),
              ...entry.value.map((val) => _HeatmapCell(val)),
            ],
          ),
        ),
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final VoidCallback? onTap;

  const _TableCell(this.text, {this.isHeader = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isHeader ? 9 : 12,
            fontWeight: isHeader ? FontWeight.w800 : FontWeight.w700,
            color: isHeader ? AppColors.textSecondary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  final int value;

  const _HeatmapCell(this.value);

  @override
  Widget build(BuildContext context) {
    // Basic scaling for heat
    double opacity = (value / 500).clamp(0.1, 0.9);

    return Container(
      height: 60,
      decoration: BoxDecoration(color: AppColors.error.withOpacity(opacity)),
      alignment: Alignment.center,
      child: Text(
        '$value',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
