import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';

class StatsCardGrid extends StatelessWidget {
  const StatsCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: MockData.nationalStats
          .map(
            (stat) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: StatsCard(
                  title: stat['title'],
                  value: stat['value'],
                  trend: stat['trend'],
                  isNegativeTrend: stat['isNegative'],
                  target: stat['target'],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class StatsCard extends StatefulWidget {
  final String title;
  final String value;
  final String trend;
  final bool isNegativeTrend;
  final String target;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
    required this.isNegativeTrend,
    required this.target,
  });

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulation of loading
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: const Color(0xFFF0F0F0),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      (widget.isNegativeTrend
                              ? AppColors.error
                              : AppColors.success)
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.trend,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: widget.isNegativeTrend
                        ? AppColors.error
                        : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.target,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
