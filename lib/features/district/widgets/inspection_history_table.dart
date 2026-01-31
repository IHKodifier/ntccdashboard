import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';

class InspectionHistoryTable extends StatelessWidget {
  const InspectionHistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inspection History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF0F0F0)),
          ),
          child: Column(
            children: [
              _buildHeader(),
              ...MockData.inspectionHistory.map(
                (h) => _buildRow(
                  h['date'],
                  h['inspector'],
                  h['type'],
                  h['status'],
                  h['color'],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: const Row(
        children: [
          Expanded(child: Text('DATE', style: _headerStyle)),
          Expanded(child: Text('INSPECTOR', style: _headerStyle)),
          Expanded(child: Text('TYPE', style: _headerStyle)),
          Expanded(child: Text('STATUS', style: _headerStyle)),
          Expanded(child: Text('ACTION', style: _headerStyle)),
        ],
      ),
    );
  }

  Widget _buildRow(
    String date,
    String inspector,
    String type,
    String status,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              inspector,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'View Report',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w800,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
