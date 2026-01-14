import 'package:bookingresidentialapartments/models/rating_model.dart';
import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/booking_model.dart';

class BookingController extends GetxController {
  final bookings = <BookingModel>[].obs;
var isLoading = false.obs;

  /// 🔹 التاب المختار
  final selectedStatus = BookingStatus.all.obs;

  /// ➕ إضافة حجز
  Future<void> addBooking(BookingModel booking) async {
    try {
      // إرسال البيانات لـ Laravel
      bool success = await ApiService.createBooking(
        apartmentId: int.parse(booking.apartment.id),
        startDate: booking.startDate.toIso8601String().split('T')[0],
        endDate: booking.endDate.toIso8601String().split('T')[0],
      );

      if (success) {
        Get.back(); // إغلاق الدايلوج
        Get.offNamed('/successfulBooking'); // صفحة النجاح
        fetchMyBookings(); // تحديث القائمة في الخلفية
      }
    } catch (e) {
      Get.snackbar("Booking Failed", e.toString());
    }
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
  Future<void> cancelBooking(String bookingId) async {
  try {
    isLoading.value = true;

    // 🔥 إلغاء فعلي من السيرفر
    bool success = await ApiService.cancelBooking(bookingId);

    if (success) {
      // 🔄 إعادة تحميل الحجوزات من Laravel
      await fetchMyBookings();

      Get.snackbar(
        "Success",
        "Booking canceled successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    isLoading.value = false;
  }
}
List<DateTimeRange> getBookedRanges({String? excludeBookingId}) {
  final ranges = <DateTimeRange>[];

  for (final booking in bookings) {
    if (booking.id == excludeBookingId) continue;
    if (booking.status == BookingStatus.canceled) continue;

    ranges.add(
      DateTimeRange(
        start: DateTime(
          booking.startDate.year,
          booking.startDate.month,
          booking.startDate.day,
        ),
        end: DateTime(
          booking.endDate.year,
          booking.endDate.month,
          booking.endDate.day,
        ),
      ),
    );
  }

  return ranges;
}

Future<void> editBookingDates({
  required String bookingId,
  required DateTime newStart,
  required DateTime newEnd,
}) async {
  try {
    isLoading.value = true;

    bool success = await ApiService.editBooking(
      bookingId: bookingId,
      startDate: newStart.toIso8601String().split('T')[0],
      endDate: newEnd.toIso8601String().split('T')[0],
    );

    if (success) {
      await fetchMyBookings(); // 🔄 إعادة تحميل من السيرفر
      Get.snackbar(
        'Success',
        'Booking updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading.value = false;
  }
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
Future<void> fetchMyBookings() async {
    try {
      isLoading.value = true;
      // نحدد الـ type بناءً على التاب المختار
      
      
      // استدعاء ApiService (تأكد من كتابة الدالة فيه)
    final responseData = await ApiService.getMyBookings('');
     List<BookingModel> fetchedBookings = responseData
        .map((e) => BookingModel.fromJson(e))
        .toList();
    bookings.assignAll(fetchedBookings);
    } catch (e) {
      Get.snackbar("Error", "Failed to load bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }
  String _mapStatusToType(BookingStatus status) {
    switch (status) {
      case BookingStatus.current: return 'current';
      case BookingStatus.previous: return 'past';
      case BookingStatus.canceled: return 'rejected';
      default: return ''; // لـ 'all'
    }
  }
}

