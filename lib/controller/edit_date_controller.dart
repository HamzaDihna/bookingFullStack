import 'package:get/get.dart';

class EditDateController extends GetxController {
  final DateTime originalStart;
  final DateTime originalEnd;
  final List<DateTime> bookedDates;

  EditDateController({
    required this.originalStart,
    required this.originalEnd,
    required this.bookedDates,
  });

  DateTime focusedDay = DateTime.now();

  DateTime? newStart;
  DateTime? newEnd;

  // =============================

  bool isPast(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(
      DateTime(today.year, today.month, today.day),
    );
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

  bool isBooked(DateTime day) {
    return bookedDates.any((d) =>
        d.year == day.year &&
        d.month == day.month &&
        d.day == day.day);
  }

  // =============================

  void onDaySelected(DateTime day) {
    if (newStart == null || (newStart != null && newEnd != null)) {
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
