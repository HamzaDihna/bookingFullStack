import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  /// حجوزات مؤكدة (لاحقاً من الباك)
  final List<DateTimeRange> bookedRanges = [
    DateTimeRange(
      start: DateTime(2025, 12, 10),
      end: DateTime(2025, 12, 15),
    ),
    DateTimeRange(
      start: DateTime(2025, 12, 20),
      end: DateTime(2025, 12, 22),
    ),
  ];

  bool isPast(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(DateTime(today.year, today.month, today.day));
  }

  bool isBooked(DateTime day) {
    return bookedRanges.any(
      (range) =>
          !day.isBefore(range.start) &&
          !day.isAfter(range.end),
    );
  }

  bool isInSelectedRange(DateTime day) {
    if (startDate == null) return false;

    if (endDate == null) {
      return isSameDay(day, startDate);
    }

    return (day.isAfter(startDate!) &&
            day.isBefore(endDate!)) ||
        isSameDay(day, startDate!) ||
        isSameDay(day, endDate!);
  }

  void onDaySelected(DateTime day) {
    if (isPast(day) || isBooked(day)) return;

    if (startDate == null || endDate != null) {
      startDate = day;
      endDate = null;
    } else {
      if (day.isBefore(startDate!)) {
        Get.snackbar(
          'Invalid',
          'End date must be after start date',
        );
        return;
      }
      endDate = day;
    }
    update();
  }
}
