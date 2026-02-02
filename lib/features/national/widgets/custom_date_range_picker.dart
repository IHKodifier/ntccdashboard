import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTimeRange) onApply;

  const CustomDateRangePicker({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApply,
  });

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedMonthStart = DateTime.now();
  DateTime _focusedMonthEnd = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    if (_startDate != null) {
      _focusedMonthStart = _startDate!;
    }
    if (_endDate != null) {
      _focusedMonthEnd = _endDate!;
    } else if (_startDate != null) {
      _focusedMonthEnd = DateTime(_startDate!.year, _startDate!.month + 1);
    }
  }

  void _onDateSelected(DateTime date, bool isStart) {
    setState(() {
      if (isStart) {
        _startDate = date;
        // If start is after end, reset end
        if (_endDate != null && _startDate!.isAfter(_endDate!)) {
          _endDate = null;
        }
        // Ensure End Date picker shows a valid month (>= start date month)
        if (_focusedMonthEnd.isBefore(DateTime(date.year, date.month))) {
          _focusedMonthEnd = DateTime(date.year, date.month);
        }
      } else {
        _endDate = date;
        // If end is before start, reset start (or handle as range flip)
        if (_startDate != null && _endDate!.isBefore(_startDate!)) {
          _startDate = _endDate;
          _endDate = null;
        }
      }
    });
  }

  int _selectedTab = 0; // 0: Start Date, 1: End Date

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final dialogWidth = isMobile ? constraints.maxWidth - 32 : 680.0;
        final dialogHeight = isMobile ? 600.0 : 520.0;

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: dialogHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                _buildHeader(context),

                // Mobile Tabs
                if (isMobile) _buildMobileTabs(),

                // Calendars
                Flexible(
                  child: isMobile
                      ? _buildMobileCalendarContent()
                      : _buildDesktopCalendarContent(),
                ),

                // Footer
                _buildFooter(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Select Date Range',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const FaIcon(FontAwesomeIcons.xmark, size: 18),
            color: AppColors.textSecondary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              title: 'Start Date',
              date: _startDate,
              isSelected: _selectedTab == 0,
              onTap: () => setState(() => _selectedTab = 0),
            ),
          ),
          Expanded(
            child: _buildTabButton(
              title: 'End Date',
              date: _endDate,
              isSelected: _selectedTab == 1,
              onTap: () => setState(() => _selectedTab = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required DateTime? date,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final dateFormat = DateFormat('MMM d, yyyy');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date != null ? dateFormat.format(date) : '--',
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileCalendarContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _selectedTab == 0
            ? _buildCalendarColumn(
                title: '', // Tabs handle title
                selectedDate: _startDate,
                focusedMonth: _focusedMonthStart,
                onMonthChanged: (date) =>
                    setState(() => _focusedMonthStart = date),
                onDateSelected: (date) => _onDateSelected(date, true),
                otherDate: _endDate,
                isStartPicker: true,
              )
            : _buildCalendarColumn(
                title: '',
                selectedDate: _endDate,
                focusedMonth: _focusedMonthEnd,
                onMonthChanged: (date) =>
                    setState(() => _focusedMonthEnd = date),
                onDateSelected: (date) => _onDateSelected(date, false),
                otherDate: _startDate,
                isStartPicker: false,
                minDate: _startDate,
              ),
      ),
    );
  }

  Widget _buildDesktopCalendarContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Start Date Calendar
            SizedBox(
              width: 280,
              child: _buildCalendarColumn(
                title: 'Start Date',
                selectedDate: _startDate,
                focusedMonth: _focusedMonthStart,
                onMonthChanged: (date) =>
                    setState(() => _focusedMonthStart = date),
                onDateSelected: (date) => _onDateSelected(date, true),
                otherDate: _endDate,
                isStartPicker: true,
              ),
            ),
            const SizedBox(width: 20),
            // Vertical Divider
            Container(width: 1, height: 300, color: const Color(0xFFEEEEEE)),
            const SizedBox(width: 20),
            // End Date Calendar
            SizedBox(
              width: 280,
              child: _buildCalendarColumn(
                title: 'End Date',
                selectedDate: _endDate,
                focusedMonth: _focusedMonthEnd,
                onMonthChanged: (date) =>
                    setState(() => _focusedMonthEnd = date),
                onDateSelected: (date) => _onDateSelected(date, false),
                otherDate: _startDate,
                isStartPicker: false,
                minDate: _startDate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Clear Button
          TextButton(
            onPressed: () {
              setState(() {
                _startDate = null;
                _endDate = null;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text('Clear'),
          ),

          // Action Buttons
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: (_startDate != null && _endDate != null)
                    ? () {
                        widget.onApply(
                          DateTimeRange(start: _startDate!, end: _endDate!),
                        );
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                ),
                child: const Text(
                  'Apply Range',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarColumn({
    required String title,
    required DateTime? selectedDate,
    required DateTime focusedMonth,
    required Function(DateTime) onMonthChanged,
    required Function(DateTime) onDateSelected,
    required DateTime? otherDate,
    required bool isStartPicker,
    DateTime? minDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        // Custom Calendar Implementation
        _buildCalendarHeader(focusedMonth, onMonthChanged, minDate),
        const SizedBox(height: 16),
        _buildCalendarGrid(
          focusedMonth,
          selectedDate,
          onDateSelected,
          otherDate,
          isStartPicker,
        ),
      ],
    );
  }

  Widget _buildCalendarHeader(
    DateTime focusedMonth,
    Function(DateTime) onMonthChanged,
    DateTime? minDate,
  ) {
    // Check if we can go back:
    // We can go back only if minDate is null OR if the current month is strictly after the minDate's month.
    bool canGoBack = true;
    if (minDate != null) {
      final minMonth = DateTime(minDate.year, minDate.month);
      final currentMonth = DateTime(focusedMonth.year, focusedMonth.month);
      if (!currentMonth.isAfter(minMonth)) {
        canGoBack = false;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: canGoBack
              ? () => onMonthChanged(
                    DateTime(focusedMonth.year, focusedMonth.month - 1),
                  )
              : null,
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 14,
            color: canGoBack
                ? AppColors.textSecondary
                : AppColors.textSecondary.withOpacity(0.3),
          ),
        ),
        Text(
          DateFormat('MMMM yyyy').format(focusedMonth),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        IconButton(
          onPressed: () => onMonthChanged(
            DateTime(focusedMonth.year, focusedMonth.month + 1),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(
    DateTime focusedMonth,
    DateTime? selectedDate,
    Function(DateTime) onDateSelected,
    DateTime? otherDate,
    bool isStartPicker,
  ) {
    final daysInMonth = DateUtils.getDaysInMonth(
      focusedMonth.year,
      focusedMonth.month,
    );
    final firstDayOffset =
        DateTime(focusedMonth.year, focusedMonth.month, 1).weekday - 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: daysInMonth + firstDayOffset,
      itemBuilder: (context, index) {
        if (index < firstDayOffset) return const SizedBox();

        final day = index - firstDayOffset + 1;
        final date = DateTime(focusedMonth.year, focusedMonth.month, day);
        bool isSelected =
            selectedDate != null && DateUtils.isSameDay(date, selectedDate);
        bool isRange = false;

        // Visual range indication logic
        if (_startDate != null && _endDate != null) {
          if (date.isAfter(_startDate!) && date.isBefore(_endDate!)) {
            isRange = true;
          }
        }

        return InkWell(
          onTap: () => onDateSelected(date),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : isRange
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: (DateUtils.isSameDay(date, DateTime.now()) && !isSelected)
                  ? Border.all(color: AppColors.primary)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : isRange
                        ? AppColors.primary
                        : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
