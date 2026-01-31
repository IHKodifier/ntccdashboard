import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import '../dashboard_provider.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);
    final isCollapsed = dashboardState.isSidebarCollapsed;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isCollapsed ? 80 : 260,
      decoration: const BoxDecoration(
        color: AppColors.sidebar,
        border: Border(right: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: isCollapsed
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // Sidebar Toggle Button
          Align(
            alignment: isCollapsed ? Alignment.center : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                onPressed: () =>
                    ref.read(dashboardProvider.notifier).toggleSidebar(),
                icon: FaIcon(
                  isCollapsed
                      ? FontAwesomeIcons.bars
                      : FontAwesomeIcons.barsStaggered,
                  color: Colors.white,
                  size: 18,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Logo Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.shieldHalved,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                if (!isCollapsed) ...[
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
                  icon: FontAwesomeIcons.gaugeHigh,
                  label: 'Overview',
                  isActive: dashboardState.module == DashboardModule.overview,
                  isCollapsed: isCollapsed,
                  onTap: () {
                    if (dashboardState.hierarchy ==
                        DashboardHierarchy.national) {
                      ref.read(dashboardProvider.notifier).navigateToNational();
                    } else {
                      ref
                          .read(dashboardProvider.notifier)
                          .setModule(DashboardModule.overview);
                    }
                  },
                ),
                _SidebarItem(
                  icon: FontAwesomeIcons.shieldHalved,
                  label: 'Compliance',
                  isActive: dashboardState.module == DashboardModule.compliance,
                  isCollapsed: isCollapsed,
                  onTap: () => ref
                      .read(dashboardProvider.notifier)
                      .navigateToCompliance(),
                ),
                _SidebarItem(
                  icon: FontAwesomeIcons.triangleExclamation,
                  label: 'Violations',
                  isActive: dashboardState.module == DashboardModule.violations,
                  isCollapsed: isCollapsed,
                  onTap: () => ref
                      .read(dashboardProvider.notifier)
                      .navigateToViolations(),
                ),
                _SidebarItem(
                  icon: FontAwesomeIcons.shop,
                  label: 'Retail',
                  isActive: dashboardState.module == DashboardModule.retail,
                  isCollapsed: isCollapsed,
                  onTap: () =>
                      ref.read(dashboardProvider.notifier).navigateToRetail(),
                ),
                _SidebarItem(
                  icon: FontAwesomeIcons.bus,
                  label: 'PSV',
                  isActive: dashboardState.module == DashboardModule.psv,
                  isCollapsed: isCollapsed,
                  onTap: () =>
                      ref.read(dashboardProvider.notifier).navigateToPSV(),
                ),
                _SidebarItem(
                  icon: FontAwesomeIcons.gavel,
                  label: 'Enforcement',
                  isActive:
                      dashboardState.module == DashboardModule.enforcement,
                  isCollapsed: isCollapsed,
                  onTap: () => ref
                      .read(dashboardProvider.notifier)
                      .navigateToEnforcement(),
                ),
                _SidebarItem(
                  icon: FontAwesomeIcons.fileLines,
                  label: 'Reports',
                  isActive: dashboardState.module == DashboardModule.reports,
                  isCollapsed: isCollapsed,
                  onTap: () =>
                      ref.read(dashboardProvider.notifier).navigateToReports(),
                ),
              ],
            ),
          ),
          // Footer
          if (!isCollapsed)
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
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
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
  final bool isCollapsed;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.isCollapsed = false,
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
            padding: EdgeInsets.symmetric(
              horizontal: isCollapsed ? 0 : 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                FaIcon(
                  icon,
                  color: isActive ? Colors.white : Colors.white54,
                  size: 18,
                ),
                if (!isCollapsed) ...[
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
