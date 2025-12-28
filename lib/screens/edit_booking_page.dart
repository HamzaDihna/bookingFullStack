import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/booking_model.dart';
import '../controller/booking/booking_controller.dart';
import '../controller/booking/edit_date_controller.dart';

class EditBookingPage extends StatelessWidget {
  const EditBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingModel booking = Get.arguments;
    final bookingController = Get.find<BookingController>();

    final controller = Get.put(
      EditDateController(
        originalStart: booking.startDate,
        originalEnd: booking.endDate,
        bookedDates: bookingController.getBookedDates(
          excludeBookingId: booking.id,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 145, 199),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        title: const Text(
          'Edit Dates',
          style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<EditDateController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 📅 Calendar (نفس SelectDatePage)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2030),
                    focusedDay: controller.focusedDay,
                
                    enabledDayPredicate: (day) {
                      return !controller.isPast(day) &&
                          !controller.isBooked(day);
                    },

                    onDaySelected: (day, focusedDay) {
                      controller.focusedDay = focusedDay;
                      controller.onDaySelected(day);
                    },

                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, _) {
                        if (controller.isBooked(day)) {
                          return _dayBox(day, Colors.red);
                        }
                        
                        if (controller.isOriginal(day)) {
                          return _dayBox(day, Colors.black);
                        }
                        if (controller.isNew(day)) {
                          return _dayBox(day, Colors.blue);
                        }
                        return null;
                      },
                    ),

                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      disabledTextStyle:
                          const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// 📌 Date info (مثل SelectDatePage)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      
                      const Text(
                        'Edit booking dates',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          _dateInfo(
                            'CHECK IN',
                            controller.newStart ?? booking.startDate,
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          _dateInfo(
                            'CHECK OUT',
                            controller.newEnd ?? booking.endDate,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
  const SizedBox(height: 16),

                const Text(
                  'Note :',
                  style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.w500),
                ),
                const Text(
                  'The request notification will be sent to the apartment owner for approval.',
                  style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic),
                ),
                const Spacer(),

                /// 🔘 Buttons (Edit Book بدل Book Now)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Exit'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.newStart != null &&
                                controller.newEnd != null
                            ? () {
                               final today = DateTime.now();
                                _showEditConfirmDialog(
    bookingController,
    booking,
    controller,
  );
   if (!controller.newStart!.isAfter(
    DateTime(today.year, today.month, today.day),
  )) {
    Get.snackbar(
      'Edit not allowed',
      'This booking has already started',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  /// ❗ تأكيد وجود تاريخ جديد
  if (controller.newStart == null ||
      controller.newEnd == null) {
    return;
  }

  /// ✅ Dialog تأكيد
  _showEditConfirmDialog(
    bookingController,
    booking,
    controller,
  );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Edit Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
Widget _dayBox(DateTime day, Color color) {
  return Container(
    margin: const EdgeInsets.all(4),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color.withOpacity(0.25),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      '${day.day}',
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _dateInfo(String title, DateTime date) {
  return Column(
    children: [
      Text(title, style: const TextStyle(color: Colors.grey)),
      const SizedBox(height: 4),
      Text(
        '${date.day}/${date.month}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
void _showEditConfirmDialog(
  BookingController bookingController,
  BookingModel booking,
  EditDateController controller,
) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Confirm Edit',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Change booking dates to:'),
          const SizedBox(height: 12),
          Text(
            'From: ${controller.newStart!.day}/'
            '${controller.newStart!.month}/'
            '${controller.newStart!.year}',
          ),
          Text(
            'To: ${controller.newEnd!.day}/'
            '${controller.newEnd!.month}/'
            '${controller.newEnd!.year}',
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
            bookingController.editBookingDates(
              booking.id,
              controller.newStart!,
              controller.newEnd!,
            );
            Get.back(); // dialog
            Get.back(); // page
            Get.back(); // page
            Get.back(); // page
          
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Yes, Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
