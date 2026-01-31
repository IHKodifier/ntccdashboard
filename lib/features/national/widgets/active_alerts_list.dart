import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../../../core/mock_data.dart';

class ActiveAlertsList extends StatelessWidget {
  const ActiveAlertsList({super.key});

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
              const Row(
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    size: 18,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Active Alerts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${MockData.activeAlerts.length} New',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...MockData.activeAlerts.expand(
            (alert) => [
              _AlertItem(
                type: AlertType.values.firstWhere(
                  (e) => e.name == alert['type'],
                ),
                title: alert['title'],
                description: alert['description'],
                time: alert['time'],
              ),
              if (MockData.activeAlerts.last != alert)
                const Divider(
                  height: 32,
                  thickness: 1,
                  color: Color(0xFFF5F5F5),
                ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: const Color(0xFFF9FAFB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'CLEAR ALL NOTIFICATIONS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum AlertType { critical, warning, system }

class _AlertItem extends StatelessWidget {
  final AlertType type;
  final String title;
  final String description;
  final String time;

  const _AlertItem({
    required this.type,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    Color accentColor;
    switch (type) {
      case AlertType.critical:
        accentColor = AppColors.error;
        break;
      case AlertType.warning:
        accentColor = AppColors.warning;
        break;
      case AlertType.system:
        accentColor = AppColors.info;
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: accentColor,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
