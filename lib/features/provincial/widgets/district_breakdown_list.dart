import 'package:flutter/material.dart';
import '../../../core/widgets/custom_shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';

class DistrictBreakdownList extends StatefulWidget {
  final Function(String) onDistrictTap;

  const DistrictBreakdownList({super.key, required this.onDistrictTap});

  @override
  State<DistrictBreakdownList> createState() => _DistrictBreakdownListState();
}

class _DistrictBreakdownListState extends State<DistrictBreakdownList> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

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
              const Text(
                'District Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View Full List',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildHeader(),
          const SizedBox(height: 12),
          if (_isLoading)
            _buildShimmerRows()
          else ...[
            ...MockData.districtBreakdown.map(
              (d) => _buildDistrictItem(
                d['name'],
                d['violations'],
                d['trend'],
                AppColors.success,
                d['action'],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Expanded(child: Text('DISTRICT', style: _headerStyle)),
        Expanded(child: Text('VIOLATIONS', style: _headerStyle)),
        Expanded(child: Text('TREND', style: _headerStyle)),
        Expanded(child: Text('ACTION TAKEN', style: _headerStyle)),
      ],
    );
  }

  Widget _buildDistrictItem(
    String name,
    int violations,
    String trend,
    Color trendColor,
    String action,
  ) {
    return InkWell(
      onTap: () => widget.onDistrictTap(name),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF9FAFB), width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '$violations',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  FaIcon(
                    trend.startsWith('+')
                        ? FontAwesomeIcons.arrowTrendUp
                        : FontAwesomeIcons.minus,
                    size: 12,
                    color: trendColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trend,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: trendColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                action,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerRows() {
    return CustomShimmer(
      child: Column(
        children: List.generate(
          5,
          (_) => Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
