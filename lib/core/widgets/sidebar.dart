import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import '../dashboard_provider.dart';

class Sidebar extends ConsumerWidget {
  final VoidCallback? onOverviewTap;

  const Sidebar({super.key, this.onOverviewTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final isOverviewActive =
        dashboardState.currentLevel == DashboardLevel.national;

    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: AppColors.sidebar,
        border: Border(right: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.security,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NTCC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        'TOBACCO CONTROL CELL',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _SidebarItem(
                  icon: Icons.grid_view_rounded,
                  label: 'Overview',
                  isActive: isOverviewActive,
                  onTap: () {
                    ref.read(dashboardProvider.notifier).navigateToNational();
                    onOverviewTap?.call();
                  },
                ),
                const _SidebarItem(
                  icon: Icons.verified_user_outlined,
                  label: 'Compliance',
                ),
                const _SidebarItem(
                  icon: Icons.warning_amber_rounded,
                  label: 'Violations',
                ),
                const _SidebarItem(
                  icon: Icons.storefront_outlined,
                  label: 'Retail',
                ),
                const _SidebarItem(
                  icon: Icons.directions_bus_outlined,
                  label: 'PSV',
                ),
                const _SidebarItem(
                  icon: Icons.gavel_outlined,
                  label: 'Enforcement',
                ),
                const _SidebarItem(
                  icon: Icons.bar_chart_rounded,
                  label: 'Reports',
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SYSTEM STATUS',
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Live Updates On',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.white54,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.white54,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
