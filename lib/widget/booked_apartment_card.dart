import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import 'apartment_card.dart';

class BookedApartmentCard extends StatelessWidget {
  final BookingModel booking;

  const BookedApartmentCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ✅ نفس كارد الـ Home بالضبط
        ApartmentCard(apartment: booking.apartment),

        /// ✅ معلومات الحجز
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dateItem('From', booking.startDate),
                _dateItem('To', booking.endDate),
                _statusChip(booking.status),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateItem(String title, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          '${date.day}/${date.month}/${date.year}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _statusChip(BookingStatus status) {
    Color color;
    String text;

    switch (status) {
      case BookingStatus.current:
        color = Colors.green;
        text = 'Current';
        break;
      case BookingStatus.previous:
        color = Colors.grey;
        text = 'Previous';
        break;
      case BookingStatus.canceled:
        color = Colors.red;
        text = 'Canceled';
        break;
      case BookingStatus.all:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
