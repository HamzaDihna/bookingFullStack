import 'package:bookingresidentialapartments/models/rating_model.dart';
import 'package:get/get.dart';
import '../../models/booking_model.dart';

class BookingController extends GetxController {
  final bookings = <BookingModel>[].obs;

  /// 🔹 التاب المختار
  final selectedStatus = BookingStatus.all.obs;

  /// ➕ إضافة حجز
  void addBooking(BookingModel booking) {
    bookings.add(booking);
  }
  List<BookingModel> get filteredBookings {
  final status = selectedStatus.value;

  if (status == BookingStatus.all) {
    return bookings.toList(); // 🔥 مهم جدًا
  }

  return bookings
      .where((booking) => booking.status == status)
      .toList();
}
void changeStatus(BookingStatus status) {
  selectedStatus.value = status;
}

  /// ❌ إلغاء حجز (مرة واحدة فقط)
  void cancelBooking(String bookingId) {
  final booking =
      bookings.firstWhere((b) => b.id == bookingId);

  if (booking.status != BookingStatus.current) return;

  final today = DateTime.now();
  final todayOnly =
      DateTime(today.year, today.month, today.day);

  final startOnly = DateTime(
    booking.startDate.year,
    booking.startDate.month,
    booking.startDate.day,
  );

  if (!startOnly.isAfter(todayOnly)) return;

  booking.status = BookingStatus.canceled;
  bookings.refresh();
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
void updateBookingStatuses() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  for (final booking in bookings) {
    final endDateOnly = DateTime(
      booking.endDate.year,
      booking.endDate.month,
      booking.endDate.day,
    );

    if (booking.status == BookingStatus.current &&
        endDateOnly.isBefore(today)) {
      booking.status = BookingStatus.previous;
    }
  }

  bookings.refresh();
}

void addRating(
  String bookingId,
  double stars,
  String? comment,
) {
  final booking =
      bookings.firstWhere((b) => b.id == bookingId);

  if (booking.status != BookingStatus.previous) return;
  if (booking.rating != null) return;

  booking.rating = RatingModel(
    stars: stars,
    comment: comment,
    createdAt: DateTime.now(),
  );

  bookings.refresh();
}

}

