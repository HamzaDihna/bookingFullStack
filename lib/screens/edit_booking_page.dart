// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:table_calendar/table_calendar.dart';
// import '../models/booking_model.dart';
// import '../controller/booking_controller.dart';
// import '../controller/select_date_controller.dart';

// class EditBookingPage extends StatefulWidget {
//   final BookingModel booking;

//   const EditBookingPage({
//     super.key,
//     required this.booking,
//   });

//   @override
//   State<EditBookingPage> createState() => _EditBookingPageState();
// }

// class _EditBookingPageState extends State<EditBookingPage> {
//   late SelectDateController dateController;
//   late BookingController bookingController;

//   @override
//   void initState() {
//     super.initState();
    
//     // تهيئة الـ Controllers
//     dateController = Get.put(
//       SelectDateController(
//         initialStart: widget.booking.startDate,
//         initialEnd: widget.booking.endDate,
//       ),
//       tag: 'edit_${widget.booking.id}',
//     );
    
//     bookingController = Get.find<BookingController>();
//   }

//   @override
//   void dispose() {
//     // تنظيف الـ Controller عند الخروج
//     Get.delete<SelectDateController>(tag: 'edit_${widget.booking.id}');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Dates'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.clear_all),
//             onPressed: () {
//               dateController.clearSelection();
//             },
//             tooltip: 'Clear selection',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             /// 📅 Calendar Section
//             Expanded(
//               child: Obx(() {
//                 return TableCalendar(
//                   firstDay: DateTime.now(),
//                   lastDay: DateTime(2030),
//                   focusedDay: dateController.focusedDay.value,
//                   rangeStartDay: dateController.startDate.value,
//                   rangeEndDay: dateController.endDate.value,
//                   calendarFormat: CalendarFormat.month,
//                   startingDayOfWeek: StartingDayOfWeek.sunday,
//                   headerStyle: const HeaderStyle(
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                   ),
//                   onDaySelected: (selectedDay, focusedDay) {
//                     dateController.onDaySelected(selectedDay, focusedDay);
//                   },
//                   selectedDayPredicate: (day) {
//                     return dateController.isInRange(day);
//                   },
//                   calendarStyle: CalendarStyle(
//                     rangeStartDecoration: const BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                     ),
//                     rangeEndDecoration: const BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                     ),
//                     withinRangeTextStyle: const TextStyle(
//                       color: Colors.black,
//                     ),
//                     rangeHighlightColor: Colors.black.withOpacity(0.2),
//                     todayDecoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       shape: BoxShape.circle,
//                     ),
//                     todayTextStyle: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 );
//               }),
//             ),

//             const SizedBox(height: 20),

//             /// 📅 Selected Dates Info
//             Obx(() {
//               final start = dateController.startDate.value;
//               final end = dateController.endDate.value;
              
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Selected Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'From:',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 Text(
//                                   start?.toString().split(' ')[0] ?? 'Not selected',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Icon(Icons.arrow_forward, color: Colors.grey),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 const Text(
//                                   'To:',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 Text(
//                                   end?.toString().split(' ')[0] ?? 'Not selected',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),

//             const SizedBox(height: 20),

//             /// 🔘 Buttons Section
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Get.back(),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       side: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Obx(() {
//                     final isDateSelected = dateController.startDate.value != null &&
//                         dateController.endDate.value != null;
                    
//                     return ElevatedButton(
//                       onPressed: isDateSelected
//                           ? () {
//                               _confirmEdit();
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: isDateSelected 
//                             ? Colors.blue.shade800 
//                             : Colors.grey.shade300,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Update Booking',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _confirmEdit() {
//     final start = dateController.startDate.value;
//     final end = dateController.endDate.value;
    
//     if (start == null || end == null) return;

//     Get.defaultDialog(
//       title: 'Confirm Update',
//       titlePadding: const EdgeInsets.only(top: 20),
//       contentPadding: const EdgeInsets.all(20),
//       content: Column(
//         children: [
//           const Text('Are you sure you want to update this booking?'),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//               const SizedBox(width: 8),
//               Text(
//                 '${start.toString().split(' ')[0]} → ${end.toString().split(' ')[0]}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           bookingController.editBooking(
//             widget.booking.id,
//             start,
//             end,
//           );
          
//           Get.back(); // إغلاق dialog
//           Get.back(); // العودة للصفحة السابقة
          
//           Get.snackbar(
//             'Success',
//             'Booking dates updated successfully',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//             duration: const Duration(seconds: 2),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green,
//           minimumSize: const Size(100, 40),
//         ),
//         child: const Text('Update', style: TextStyle(color: Colors.white)),
//       ),
//       cancel: OutlinedButton(
//         onPressed: () => Get.back(),
//         child: const Text('Cancel'),
//       ),
//     );
//   }
// }