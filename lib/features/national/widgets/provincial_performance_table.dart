import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/custom_shimmer.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';
import '../../../core/dashboard_provider.dart';

class ProvincialPerformanceTable extends ConsumerStatefulWidget {
  final Function(String) onProvinceTap;

  const ProvincialPerformanceTable({super.key, required this.onProvinceTap});

  @override
  ConsumerState<ProvincialPerformanceTable> createState() =>
      _ProvincialPerformanceTableState();
}

class _ProvincialPerformanceTableState
    extends ConsumerState<ProvincialPerformanceTable> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFilterLoading = ref.watch(
      dashboardProvider.select((s) => s.isFilterLoading),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Provincial Performance Scorecard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All Data',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          _buildTableHeader(),
          if (_isLoading || isFilterLoading)
            _buildShimmerRows()
          else
            Column(
              children: [
                ...MockData.provincialPerformance.map(
                  (p) => _buildRow(
                    p['name'] as String,
                    p['score'] as int,
                    p['inspections'] as int,
                    p['status'] as String,
                    p['color'] as Color,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: const Row(
        children: [
          Expanded(flex: 2, child: Text('PROVINCE', style: _headerStyle)),
          Expanded(
            flex: 3,
            child: Text('COMPLIANCE SCORE', style: _headerStyle),
          ),
          Expanded(flex: 1, child: Text('INSPECTIONS', style: _headerStyle)),
          Expanded(
            flex: 1,
            child: Center(child: Text('STATUS', style: _headerStyle)),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String province,
    int score,
    int inspections,
    String status,
    Color statusColor,
  ) {
    return InkWell(
      onTap: () => widget.onProvinceTap(province),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                province,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: score / 100,
                        backgroundColor: const Color(0xFFE0E0E0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 40), // Spacing consistent with design
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                inspections.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    ),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: statusColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
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
          (index) => Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
    letterSpacing: 1.1,
  );
}
