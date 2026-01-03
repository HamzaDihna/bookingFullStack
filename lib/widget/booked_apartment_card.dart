import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';

class BookedApartmentCard extends StatelessWidget {
  final BookingModel booking;
  final bool enableNavigation;

  const BookedApartmentCard({
    super.key,
    required this.booking,
    this.enableNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    final apartment = booking.apartment;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
       color: Theme.of(context).cardColor,
 
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          /// 🖼 Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              apartment.image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// ℹ️ Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apartment.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  apartment.location,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${booking.startDate.day}/${booking.startDate.month}'
                  ' → '
                  '${booking.endDate.day}/${booking.endDate.month}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                _statusChip(booking.status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(BookingStatus status) {
    Color color;

    switch (status) {
      case BookingStatus.current:
        color = Colors.blue;
        break;
      case BookingStatus.previous:
        color = Colors.grey;
        break;
      case BookingStatus.canceled:
        color = Colors.red;
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.name.capitalizeFirst!,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}
