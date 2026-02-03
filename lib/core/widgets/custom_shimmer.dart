import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const CustomShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.shimmerBase,
      highlightColor: highlightColor ?? AppColors.shimmerHighlight,
      child: child,
    );
  }
}
