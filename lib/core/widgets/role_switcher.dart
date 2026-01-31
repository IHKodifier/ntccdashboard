import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import '../dashboard_provider.dart';

class RoleSwitcher extends ConsumerStatefulWidget {
  const RoleSwitcher({super.key});

  @override
  ConsumerState<RoleSwitcher> createState() => _RoleSwitcherState();
}

class _RoleSwitcherState extends ConsumerState<RoleSwitcher> {
  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);

    return PopupMenuButton<void>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              _getRoleIcon(dashboardState.currentRole),
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10),
            Text(
              _getRoleLabel(dashboardState),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            const FaIcon(
              FontAwesomeIcons.chevronDown,
              size: 12,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        // National User
        PopupMenuItem(
          onTap: () {
            ref.read(dashboardProvider.notifier).switchToNationalUser();
          },
          child: _buildRoleOption(
            FontAwesomeIcons.globe,
            'National Admin',
            'Full access to all regions',
            dashboardState.currentRole == UserRole.national,
          ),
        ),
        const PopupMenuDivider(),

        // Provincial Users
        ..._buildProvincialOptions(),

        const PopupMenuDivider(),

        // District Users
        ..._buildDistrictOptions(),
      ],
    );
  }

  List<PopupMenuEntry<void>> _buildProvincialOptions() {
    final provinces = ['Punjab', 'Sindh', 'KP', 'Balochistan', 'ICT'];
    final dashboardState = ref.watch(dashboardProvider);

    return provinces.map((province) {
      final isActive =
          dashboardState.currentRole == UserRole.provincial &&
          dashboardState.assignedProvince == province;

      return PopupMenuItem(
        onTap: () {
          ref.read(dashboardProvider.notifier).switchToProvincialUser(province);
        },
        child: _buildRoleOption(
          FontAwesomeIcons.mapLocationDot,
          'Provincial: $province',
          'Access to $province only',
          isActive,
        ),
      );
    }).toList();
  }

  List<PopupMenuEntry<void>> _buildDistrictOptions() {
    // Sample districts for demonstration
    final districts = [
      {'province': 'Punjab', 'district': 'Lahore'},
      {'province': 'Punjab', 'district': 'Rawalpindi'},
      {'province': 'Sindh', 'district': 'Karachi'},
      {'province': 'KP', 'district': 'Peshawar'},
      {'province': 'ICT', 'district': 'Islamabad'},
    ];
    final dashboardState = ref.watch(dashboardProvider);

    return districts.map((item) {
      final isActive =
          dashboardState.currentRole == UserRole.district &&
          dashboardState.assignedDistrict == item['district'];

      return PopupMenuItem(
        onTap: () {
          ref
              .read(dashboardProvider.notifier)
              .switchToDistrictUser(item['province']!, item['district']!);
        },
        child: _buildRoleOption(
          FontAwesomeIcons.building,
          'District: ${item['district']}',
          '${item['province']} / ${item['district']}',
          isActive,
        ),
      );
    }).toList();
  }

  Widget _buildRoleOption(
    IconData icon,
    String title,
    String subtitle,
    bool isActive,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              icon,
              size: 16,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                    color: isActive ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            const FaIcon(
              FontAwesomeIcons.check,
              size: 14,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.national:
        return FontAwesomeIcons.globe;
      case UserRole.provincial:
        return FontAwesomeIcons.mapLocationDot;
      case UserRole.district:
        return FontAwesomeIcons.building;
    }
  }

  String _getRoleLabel(DashboardState state) {
    switch (state.currentRole) {
      case UserRole.national:
        return 'National Admin';
      case UserRole.provincial:
        return 'Provincial: ${state.assignedProvince}';
      case UserRole.district:
        return 'District: ${state.assignedDistrict}';
    }
  }
}
