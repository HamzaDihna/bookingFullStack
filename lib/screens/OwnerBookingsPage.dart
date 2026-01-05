import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/controller/owner_booking_controller.dart';
import 'package:bookingresidentialapartments/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OwnerBookingsPage extends StatelessWidget {
  final controller = Get.put(OwnerBookingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
       backgroundColor:  Color.fromARGB(255, 95, 95, 95),
        title:  Text(
          'Order Booking'.tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () {
    final navController = Get.find<NavigationController>();
    navController.changeIndex(0); // 🏠 Home
  },
),),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (_, i) {
            final booking = controller.bookings[i];

            return Card(
  elevation: 4,
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ClipRRect(
        //     borderRadius: BorderRadius.circular(12),
        //     child:_buildApartmentImage(booking.apartment.image),
        //   ),

        //   const SizedBox(width: 12),

        Text(
          booking.apartment.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${booking.startDate.day}/${booking.startDate.month} → ${booking.endDate.day}/${booking.endDate.month}',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _statusChip(booking.status),
            if (booking.status == BookingStatus.pending)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => controller.approve(booking.id),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => controller.reject(booking.id),
                  ),
                ],
              )
          ],
        )
      ],
    ),
  ),
);
  },
        );
      }),
    );
  }
}
Widget _bookingImage(String image) {
  if (image.startsWith('http')) {
    return Image.network(
      image,
      width: 90,
      height: 90,
      fit: BoxFit.cover,
    );
  }

  return Image.asset(
    'assets/images/Group.png',
    width: 90,
    height: 90,
    fit: BoxFit.cover,
  );
}

Widget _statusChip(BookingStatus status) {
  Color color;

  switch (status) {
    case BookingStatus.pending:
      color = Colors.green;
      break;
    case BookingStatus.canceled:
      color = Colors.red;
      break;
    case BookingStatus.current:
      color = Colors.blue;
      break;
    default:
      color = Colors.grey;
  }

  return Chip(
    label: Text(status.name),
    backgroundColor: color.withOpacity(0.15),
    labelStyle: TextStyle(color: color),
  );
}
