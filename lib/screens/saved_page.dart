import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/widget/booked_apartment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking/booking_controller.dart';
import '../models/booking_model.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
  
}

class _SavedPageState extends State<SavedPage> {
   @override
  void initState() {
    super.initState();
    Get.find<BookingController>().updateBookingStatuses();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.find<BookingController>().fetchMyBookings();
  });
  }

  @override
  Widget build(BuildContext context) {
  
    final BookingController controller =
        Get.find<BookingController>();

    return Scaffold(
     appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 145, 199),
        title: const Text(
          'The Reserved',
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
),

      ),
  body: Column(
        children: [
          /// 🔹 Tabs (All / Current / Previous / Canceled)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: BookingStatus.values.map((status) {
                  final isSelected =
                      controller.selectedStatus.value == status;

                  return ChoiceChip(
                    label: Text(status.name.capitalizeFirst!),
                    selected: isSelected,
                    onSelected: (_) =>
                        controller.changeStatus(status),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color:
                          isSelected ? Colors.white : Colors.black,
                    ),
                    
                  );
                  
                }).toList(),
               
              );
              
            }),
            
          ),

          /// 🔹 LISTVIEW (المهم)
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }
              if (controller.filteredBookings.isEmpty) {
                return const Center(
                  child: Text(
                    'No bookings found',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              
             return ListView.separated(
              
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                itemCount: controller.filteredBookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
  final booking = controller.filteredBookings[index];

  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 600),
    transitionBuilder: (child, animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
    child: GestureDetector(
      key: ValueKey(booking.id), 
      onTap: () {
        Get.toNamed(
          '/bookingDetails',
          arguments: booking.id,
        );
      },
      child: BookedApartmentCard(
  booking: booking,
  enableNavigation: false,
),

    ),
  );
},
              );
            }),
          ),
          
        ],
      ),
    );
  }
}
