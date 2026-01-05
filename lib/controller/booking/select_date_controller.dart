import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
@override
void onInit() {
  loadBlockedDates(Get.arguments.id);
  super.onInit();
}

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
Future<void> loadBlockedDates(String apartmentId) async {
  final res = await ApiService.get('apartments/$apartmentId/blocked-dates');
      final List list = res['data'];
  bookedRanges.clear();

  for (final b in list) {
    bookedRanges.add(
      DateTimeRange(
        start: DateTime.parse(b['start_date']),
        end: DateTime.parse(b['end_date']),
      ),
    );
  }

  update();
}

  bool isPast(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(DateTime(today.year, today.month, today.day));
  }

  bool isBooked(DateTime day) {
  final normalizedDay = DateTime(day.year, day.month, day.day);

  return bookedRanges.any((range) {
    final start = DateTime(
      range.start.year,
      range.start.month,
      range.start.day,
    );
    final end = DateTime(
      range.end.year,
      range.end.month,
      range.end.day,
    );

    return !normalizedDay.isBefore(start) &&
           !normalizedDay.isAfter(end);
  });
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
