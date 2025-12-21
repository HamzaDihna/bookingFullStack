import 'package:get/get.dart';
import '../models/booked_range_model.dart';

class SelectDateController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  /// الحجوزات المؤكدة فقط (من الباك لاحقًا)
  final bookedRanges = <BookedRange>[
  BookedRange(
    start: DateTime(2025, 12, 10),
    end: DateTime(2025, 12, 15),
  ),
  BookedRange(
    start: DateTime(2025, 12, 20),
    end: DateTime(2025, 12, 22),
  ),
];

  bool isPast(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(
      DateTime(today.year, today.month, today.day),
    );
  }
  bool isInRange(DateTime day, DateTime start, DateTime end) {
    return !day.isBefore(start) && !day.isAfter(end);
  }
  bool isBooked(DateTime day) {
    return bookedRanges.any(
      (range) => isInRange(day, range.start, range.end),
    );
  }
  bool isRangeOverlapping(DateTime start, DateTime end) {
    return bookedRanges.any((range) {
      return start.isBefore(range.end) &&
          end.isAfter(range.start);
    });
  }


  void onDaySelected(DateTime day) {
    if (isPast(day) || isBooked(day)) return;

    if (startDate == null || endDate != null) {
      startDate = day;
      endDate = null;
    } else {
      if (day.isBefore(startDate!)) {
        Get.snackbar(
          'Invalid range',
          'End date must be after start date',
        );
        return;
      }

      if (isRangeOverlapping(startDate!, day)) {
        Get.snackbar(
          'Unavailable',
          'Selected range overlaps with existing booking',
        );
        return;
      }

      endDate = day;
    }

    update();
  }
  
}
