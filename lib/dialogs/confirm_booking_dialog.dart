import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/select_date_controller.dart';
import '../controller/booking_controller.dart';
import '../models/booking_model.dart';
import '../models/apartment_model.dart';

void showConfirmBookingDialog(
  BuildContext context,
  SelectDateController controller,
  ApartmentModel apartment,
) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Confirm Booking',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('You are about to book this apartment for:'),
          const SizedBox(height: 12),
          Text(
            'From: ${controller.startDate!.day}/'
            '${controller.startDate!.month}/'
            '${controller.startDate!.year}',
          ),
          Text(
            'To: ${controller.endDate!.day}/'
            '${controller.endDate!.month}/'
            '${controller.endDate!.year}',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final bookingController =
                Get.find<BookingController>();

            bookingController.addBooking(
              BookingModel(
                id: DateTime.now()
                    .millisecondsSinceEpoch
                    .toString(),
                apartment: apartment,
                startDate: controller.startDate!,
                endDate: controller.endDate!,
              ),
            );

            Get.back();
            Get.offNamed('/successfulBooking');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}