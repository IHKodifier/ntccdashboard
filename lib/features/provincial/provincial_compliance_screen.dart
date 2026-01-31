import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants.dart';
import '../national/widgets/filter_bar.dart';

class ProvincialComplianceScreen extends ConsumerWidget {
  const ProvincialComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(),
          const SizedBox(height: 32),
          const NationalFilterBar(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildComplianceByPlaceType()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildProvincialLeagueTable()),
            ],
          ),
          const SizedBox(height: 32),
          _buildDetailedComplianceTable(),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provincial Dashboard: Compliance Analysis',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Strategic oversight and provincial benchmarking of tobacco control compliance',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        _buildAdvancedFilterButton(),
      ],
    );
  }

  Widget _buildAdvancedFilterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
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
          FaIcon(FontAwesomeIcons.filter, size: 14, color: Colors.white),
          SizedBox(width: 12),
          Text(
            'Advanced Filter',
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

  Widget _buildComplianceByPlaceType() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Compliance by Place Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildPlaceTypeBar('Educational Institutions', 0.885, Colors.green),
          _buildPlaceTypeBar('Public Transport', 0.742, Colors.orange),
          _buildPlaceTypeBar('Healthcare Facilities', 0.921, Colors.green),
          _buildPlaceTypeBar('Restaurants & Hotels', 0.618, Colors.red),
          _buildPlaceTypeBar('Government Offices', 0.824, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildPlaceTypeBar(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${(value * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvincialLeagueTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Provincial League Table',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Ranking by overall compliance score',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          _buildLeagueRow(
            1,
            'ICT',
            'CAPITAL REGION',
            '91.4%',
            '+ 1.2%',
            Colors.green,
          ),
          _buildLeagueRow(
            2,
            'Punjab',
            'PROVINCE',
            '82.1%',
            '- 0.5%',
            Colors.red,
          ),
          _buildLeagueRow(3, 'KP', 'PROVINCE', '78.5%', '- 2.4%', Colors.green),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'FULL COMPARATIVE REPORT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueRow(
    int rank,
    String name,
    String subtitle,
    String score,
    String trend,
    Color trendColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: trendColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedComplianceTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Detailed Compliance Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 20),
                  const FaIcon(
                    FontAwesomeIcons.fileArrowDown,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTableHeader(),
          _buildTableRow(
            'Punjab / Lahore',
            '4,120',
            '84.5%',
            '79.4%',
            '91.2%',
            'ON TRACK',
          ),
          _buildTableRow(
            'Punjab / Rawalpindi',
            '2,840',
            '79.1%',
            '71.0%',
            '86.4%',
            'ON TRACK',
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('PROVINCE / DISTRICT', style: _headerStyle),
          ),
          Expanded(child: Text('TOTAL INSPECTIONS', style: _headerStyle)),
          Expanded(child: Text('OVERALL COMPLIANCE', style: _headerStyle)),
          Expanded(child: Text('PUBLIC TRANSIT %', style: _headerStyle)),
          Expanded(child: Text('SCHOOLS %', style: _headerStyle)),
          Expanded(child: Text('STATUS', style: _headerStyle)),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    String area,
    String inspections,
    String compliance,
    String transit,
    String schools,
    String status,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              area,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          Expanded(child: Text(inspections, style: _cellStyle)),
          Expanded(
            child: Text(
              compliance,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(child: Text(transit, style: _cellStyle)),
          Expanded(child: Text(schools, style: _cellStyle)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const _cellStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}


