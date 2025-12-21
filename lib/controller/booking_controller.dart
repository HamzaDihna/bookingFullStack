import 'package:get/get.dart';
import '../models/booking_model.dart';

class BookingController extends GetxController {
  final bookings = <BookingModel>[].obs;
  final selectedStatus = BookingStatus.all.obs;

  @override
  void onInit() {
    super.onInit();
    _autoUpdateBookingStatus();
  }

  void addBooking(BookingModel booking) {
    bookings.add(booking);
    _autoUpdateBookingStatus();
  }

  void changeStatus(BookingStatus status) {
    selectedStatus.value = status;
  }

  void _autoUpdateBookingStatus() {
    final now = DateTime.now();

    for (var booking in bookings) {
      if (booking.status == BookingStatus.canceled) {
        continue;
      }

      if (booking.endDate.isBefore(
        DateTime(now.year, now.month, now.day),
      )) {
        booking.status = BookingStatus.previous;
      } else if (booking.startDate.isBefore(now) &&
          booking.endDate.isAfter(now)) {
        booking.status = BookingStatus.current;
      }
    }

    bookings.refresh();
  }

  List<BookingModel> get filteredBookings {
    if (selectedStatus.value == BookingStatus.all) {
      return bookings;
    }
    return bookings
        .where((b) => b.status == selectedStatus.value)
        .toList();
  }
}
