import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/booking/select_date_controller.dart';
import '../controller/booking/booking_controller.dart';
import '../models/booking_model.dart';
import '../models/apartment_model.dart';

void showConfirmBookingDialog(
  BuildContext context,
  SelectDateController controller,
  ApartmentModel apartment,
) {
  final selectedPaymentMethod = RxnString();

  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Confirm Booking',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Obx(() => Column(
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

    const SizedBox(height: 16),
    const Text(
      'Select payment method',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),

    RadioListTile<String>(
      title: const Text('Cash'),
      value: 'cash',
      groupValue: selectedPaymentMethod.value,
      onChanged: (value) {
        selectedPaymentMethod.value = value;
      },
    ),
    RadioListTile<String>(
      title: const Text('Card'),
      value: 'card',
      groupValue: selectedPaymentMethod.value,
      onChanged: (value) {
        selectedPaymentMethod.value = value;
      },
    ),
  ],
)),
 actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
  onPressed: () async {
    if (selectedPaymentMethod.value == null) {
      Get.snackbar(
        'Payment Required',
        'Please select a payment method',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final bookingController = Get.find<BookingController>();

    final newBooking = BookingModel(
      id: "0",
      apartment: apartment,
      startDate: controller.startDate!,
      endDate: controller.endDate!,
    );

    await bookingController.addBooking(newBooking);
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