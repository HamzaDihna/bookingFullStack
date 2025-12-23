import 'package:get/get.dart';
import '../models/booking_model.dart';

class BookingController extends GetxController {
  final bookings = <BookingModel>[].obs;

  /// 🔹 التاب المختار
  final selectedStatus = BookingStatus.all.obs;

  /// ➕ إضافة حجز
  void addBooking(BookingModel booking) {
    bookings.add(booking);
  }

  /// ❌ إلغاء حجز (مرة واحدة فقط)
  void cancelBooking(String bookingId) {
    final booking =
        bookings.firstWhere((b) => b.id == bookingId);

    if (booking.status == BookingStatus.canceled) return;

    booking.status = BookingStatus.canceled;
    bookings.refresh();
  }

  /// 🔄 تغيير التاب
  void changeStatus(BookingStatus status) {
    selectedStatus.value = status;
  }

  /// 📋 الحجوزات حسب التاب
  List<BookingModel> get filteredBookings {
    if (selectedStatus.value == BookingStatus.all) {
      return bookings;
    }

    return bookings
        .where((b) => b.status == selectedStatus.value)
        .toList();
  }
void editBookingDates(
  String bookingId,
  DateTime newStart,
  DateTime newEnd,
) {
  final booking =
      bookings.firstWhere((b) => b.id == bookingId);

  booking.startDate = newStart;
  booking.endDate = newEnd;

  bookings.refresh();
}

List<DateTime> getBookedDates({String? excludeBookingId}) {
  final dates = <DateTime>[];

  for (final booking in bookings) {
    if (booking.id == excludeBookingId) continue;
    if (booking.status == BookingStatus.canceled) continue;

    DateTime day = booking.startDate;
    while (!day.isAfter(booking.endDate)) {
      dates.add(day);
      day = day.add(const Duration(days: 1));
    }
  }

  return dates;
}
  
}

