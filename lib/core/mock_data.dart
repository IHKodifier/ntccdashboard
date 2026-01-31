import 'package:flutter/material.dart';

class MockData {
  // National KPI Stats
  static const List<Map<String, dynamic>> nationalStats = [
    {
      'title': 'Compliance Rate',
      'value': '78.4%',
      'trend': '-2.1%',
      'isNegative': true,
      'target': 'Target: 85.0%',
    },
    {
      'title': 'Total Inspections',
      'value': '24,567',
      'trend': '+5.4%',
      'isNegative': false,
      'target': 'Across all districts',
    },
    {
      'title': 'Violation Rate',
      'value': '43.2%',
      'trend': '+1.2%',
      'isNegative': true,
      'target': 'Verified incidents',
    },
    {
      'title': 'Active Cases',
      'value': '1,234',
      'trend': '-0.5%',
      'isNegative': false,
      'target': 'In legal process',
    },
  ];

  // Provincial Performance Scorecard
  static const List<Map<String, dynamic>> provincialPerformance = [
    {
      'name': 'Punjab',
      'score': 82,
      'inspections': 12450,
      'status': 'HIGH',
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Sindh',
      'score': 65,
      'inspections': 6120,
      'status': 'MEDIUM',
      'color': Color(0xFFFFA000),
    },
    {
      'name': 'Khyber Pakhtunkhwa',
      'score': 78,
      'inspections': 3890,
      'status': 'HIGH',
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Balochistan',
      'score': 45,
      'inspections': 1245,
      'status': 'LOW',
      'color': Color(0xFFD32F2F),
    },
    {
      'name': 'ICT',
      'score': 91,
      'inspections': 862,
      'status': 'CRITICAL',
      'color': Colors.teal,
    },
  ];

  // Active Alerts
  static const List<Map<String, dynamic>> activeAlerts = [
    {
      'type': 'critical',
      'title': 'Violation Spike Detected',
      'description':
          'Lahore District reported 150+ violations in the last 24 hours.',
      'time': '10m ago',
    },
    {
      'type': 'warning',
      'title': 'Report Pending',
      'description':
          'Monthly compliance report for Sindh Province is overdue by 48 hours.',
      'time': '2h ago',
    },
    {
      'type': 'critical',
      'title': 'Enforcement Alert',
      'description':
          'Unauthorized tobacco advertisement detected near 3 educational zones.',
      'time': '5h ago',
    },
    {
      'type': 'system',
      'title': 'Database Sync',
      'description':
          'Provincial database sync failed for Gilgit-Baltistan region.',
      'time': '1d ago',
    },
  ];

  // Provincial: Violation Distribution (fl_chart data)
  static const List<Map<String, dynamic>> violationDistribution = [
    {'label': 'No Signage (45%)', 'value': 45.0, 'color': Color(0xFF3B82F6)},
    {
      'label': 'Public Smoking (20%)',
      'value': 20.0,
      'color': Color(0xFF10B981),
    },
    {
      'label': 'Sale to Minors (15%)',
      'value': 15.0,
      'color': Color(0xFFF59E0B),
    },
    {'label': 'Others (20%)', 'value': 20.0, 'color': Color(0xFFEF4444)},
  ];

  // Provincial: District Breakdown
  static const List<Map<String, dynamic>> districtBreakdown = [
    {
      'name': 'Lahore',
      'violations': 842,
      'trend': '+12%',
      'action': '78% Complied',
    },
    {
      'name': 'Faisalabad',
      'violations': 521,
      'trend': '+4%',
      'action': '62% Complied',
    },
    {
      'name': 'Rawalpindi',
      'violations': 488,
      'trend': '-0%',
      'action': '81% Complied',
    },
    {
      'name': 'Multan',
      'violations': 390,
      'trend': '+8%',
      'action': '54% Complied',
    },
    {
      'name': 'Gujranwala',
      'violations': 312,
      'trend': '+2%',
      'action': '90% Complied',
    },
  ];

  // District Heatmap Data
  static const List<String> heatmapTypes = [
    'NO SIGNAGE',
    'SALE TO MINORS',
    'PUBLIC SMOKING',
    'LOOSE CIGARETTES',
    'POINT OF SALE ADV',
    'SMOKING IN TRANSIT',
    'NEAR EDU INST',
  ];

  static const Map<String, List<int>> heatmapData = {
    'Lahore': [342, 210, 451, 112, 45, 231, 302],
    'Faisalabad': [212, 102, 314, 256, 22, 123, 198],
    'Rawalpindi': [120, 321, 110, 188, 455, 67, 145],
    'Multan': [245, 45, 212, 101, 12, 345, 412],
  };

  // Top Repeat Offenders
  static const List<Map<String, dynamic>> topOffenders = [
    {
      'name': 'Gulberg Main Market Complex',
      'type': 'Commercial Hub',
      'district': 'Lahore',
      'category': 'Public Smoking',
      'violations': 12,
      'status': 'ACTIVE',
      'subStatus': 'WARNING',
      'date': '2 days ago',
    },
    {
      'name': 'Faisalabad Bus Terminal (Main)',
      'type': 'Public Transport',
      'district': 'Faisalabad',
      'category': 'Smoking in Transit',
      'violations': 8,
      'status': 'PENDING FINE',
      'subStatus': '',
      'date': '5 days ago',
    },
    {
      'name': 'Sahiwal Boys High School Area',
      'type': 'Educational Zone',
      'district': 'Sahiwal',
      'category': 'Sale to Minors',
      'violations': 7,
      'status': 'ESCALATED',
      'subStatus': '',
      'date': '1 week ago',
    },
  ];

  // District Detail: Inspection History
  static const List<Map<String, dynamic>> inspectionHistory = [
    {
      'date': '12 Oct 2023',
      'inspector': 'Ahmed Raza',
      'type': 'Regular Hygiene',
      'status': 'Failed',
      'color': Color(0xFFD32F2F),
    },
    {
      'date': '15 Aug 2023',
      'inspector': 'Sara Khan',
      'type': 'License Renewal',
      'status': 'Passed',
      'color': Color(0xFF4CAF50),
    },
    {
      'date': '20 Jun 2023',
      'inspector': 'Ahmed Raza',
      'type': 'Complaint Follow-up',
      'status': 'Warning',
      'color': Color(0xFFFFA000),
    },
  ];
}
