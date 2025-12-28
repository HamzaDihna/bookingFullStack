import 'package:bookingresidentialapartments/controller/booking/booking_controller.dart';
import 'package:bookingresidentialapartments/controller/booking/edit_date_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/dialogs/confirm_booking_dialog.dart';
import 'package:bookingresidentialapartments/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/apartment_model.dart';
import '../controller/booking/select_date_controller.dart';

class SelectDatePage extends StatelessWidget {
  SelectDatePage({super.key});

  final controller = Get.put(SelectDateController());

  @override
  Widget build(BuildContext context) {
    final apartment = Get.arguments as ApartmentModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 145, 199),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () {
  Get.back(); // 🏠 Home
  },),
        title: const Text(
          'Select Dates',
          style: TextStyle(color: Colors.white),
        ),
        
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<SelectDateController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Calendar
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TableCalendar(
                    daysOfWeekStyle: DaysOfWeekStyle(
  weekdayStyle: const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
  ),
  weekendStyle: const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
  ),
),
  firstDay: DateTime.now(),
  lastDay: DateTime(2030),
  focusedDay: controller.focusedDay,
  calendarFormat: CalendarFormat.month,

  enabledDayPredicate: (day) {
    return !controller.isPast(day) && !controller.isBooked(day);
  },

  onDaySelected: (selectedDay, focusedDay) {
    controller.focusedDay = focusedDay;
    controller.onDaySelected(selectedDay);
  },

  selectedDayPredicate: (day) {
    if (controller.startDate == null) return false;

    if (controller.endDate == null) {
      return isSameDay(day, controller.startDate);
    }

    return (day.isAfter(controller.startDate!) &&
            day.isBefore(controller.endDate!)) ||
        isSameDay(day, controller.startDate!) ||
        isSameDay(day, controller.endDate!);
  },

  calendarStyle: CalendarStyle(
    rangeHighlightColor: Colors.blue.shade200,
    rangeStartDecoration: const BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    rangeEndDecoration: const BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    selectedDecoration: const BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    todayDecoration: BoxDecoration(
      color: Colors.blue.shade100,
      shape: BoxShape.circle,
    ),
    disabledTextStyle: const TextStyle(color: Colors.grey),
  ),

  calendarBuilders: CalendarBuilders(
    disabledBuilder: (context, day, _) {
      if (controller.isBooked(day)) {
        return _bookedDay(day);
      }
      return null;
    },
  ),
),

                ),

                const SizedBox(height: 20),

                /// Booking info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [
                        Center(child: Text('Book apartment',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                        SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      
                          _dateInfo(
                            'CHECK IN',
                            controller.startDate,
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              
                               borderRadius: BorderRadius.circular(15),
                                  
                            ),
                            child:Icon(Icons.arrow_forward, color: Colors.white),),
                          _dateInfo(
                            'CHECK OUT',
                            controller.endDate,
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
  onPressed: () {
    if (controller.startDate == null ||
        controller.endDate == null) {
      Get.snackbar(
        'Error',
        'Please select start and end dates',
      );
      return;
    }

    showConfirmBookingDialog(context, controller, apartment);
  },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bookedDay(DateTime day) {
    return Container(
      margin: const EdgeInsets.all(6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${day.day}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _dateInfo(String title, DateTime? date) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          date == null
              ? '--'
              : '${date.day}/${date.month}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
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
