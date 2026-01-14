import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDateController extends GetxController {
  final DateTime originalStart;
  final DateTime originalEnd;
  final String apartmentId;
  final String bookingId;

  EditDateController({
    required this.originalStart,
    required this.originalEnd,
    required this.apartmentId,
    required this.bookingId,
  });

  DateTime focusedDay = DateTime.now();
  DateTime? newStart;
  DateTime? newEnd;

  final List<DateTimeRange> bookedRanges = [];

  @override
  void onInit() {
    loadBlockedDates();
    super.onInit();
  }

  /// 🔴 تحميل التواريخ المحجوزة من السيرفر
  Future<void> loadBlockedDates() async {
    final res =
        await ApiService.get('apartments/$apartmentId/blocked-dates');

    final List list = res['data'];
    bookedRanges.clear();

    for (final b in list) {
      // ❗️ استثناء الحجز الحالي
      if (b['booking_id'].toString() == bookingId) continue;

      bookedRanges.add(
        DateTimeRange(
          start: DateTime.parse(b['start_date']),
          end: DateTime.parse(b['end_date']),
        ),
      );
    }

    update();
  }

  // =============================

  bool isPast(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(DateTime(today.year, today.month, today.day));
  }

  bool isOriginal(DateTime day) {
    return !day.isBefore(originalStart) &&
        !day.isAfter(originalEnd);
  }

  bool isNew(DateTime day) {
    if (newStart == null || newEnd == null) return false;
    return !day.isBefore(newStart!) &&
        !day.isAfter(newEnd!);
  }

  /// 🔥 نفس SelectDate بالضبط
  bool isBooked(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);

    return bookedRanges.any((range) {
      final start =
          DateTime(range.start.year, range.start.month, range.start.day);
      final end =
          DateTime(range.end.year, range.end.month, range.end.day);

      return !d.isBefore(start) && !d.isAfter(end);
    });
  }

  void onDaySelected(DateTime day) {
    if (isPast(day) || isBooked(day)) return;

    if (newStart == null || newEnd != null) {
      newStart = day;
      newEnd = null;
    } else if (day.isAfter(newStart!)) {
      newEnd = day;
    } else {
      newStart = day;
    }

    update();
  }
}
