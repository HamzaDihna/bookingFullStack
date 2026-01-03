import 'package:bookingresidentialapartments/widget/apartment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../controller/booking/booking_controller.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
   final bookingId = Get.arguments as String;
    final bookingController = Get.find<BookingController>();
return Obx((){
  final booking = bookingController.bookings.firstWhere((b) => b.id == bookingId);
  final apartment=booking.apartment;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          /// 🔹 Image
          Image.asset(
            apartment.image,
            height: 360,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          /// 🔹 Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (_, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title + Favorite
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            apartment.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// Location
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(apartment.location),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// Price
                      /// 💰 Price + ⭐ Rating
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${apartment.price}\$',
          style: const TextStyle(
            fontSize: 26,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
         Text('Per Day'.tr),
      ],
    ),

    /// ⭐ Rating UI
    if (booking.status == BookingStatus.previous)
      booking.rating == null
          ? InkWell(
              onTap: () {
                _showRatingDialog(
                  booking,
                  bookingController,
                );
              },
              child: Row(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_border,
                    color: Colors.orange,
                    size: 28,
                  ),
                ),
              ),
            )
          : Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < booking.rating!.stars.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.orange,
                  size: 26,
                ),
              ),
            ),
  ],
),

                      const SizedBox(height: 20),

                      /// Rooms + Wifi
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _infoItem(
                                  'Rooms', '${apartment.rooms}'),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: _infoItem(
                                'Free Wifi',
                                apartment.hasWifi ? 'Yes' : 'No',
                              ),
                            ),
                          ],
                          
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(apartment.description),

                      const SizedBox(height: 30),

                      /// 🔥 Buttons Section
                      _buildActionButtons(
                        booking,
                        bookingController,
                      ),
                    ],
                    
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  });
  }


  /// 🔘 Buttons logic
  Widget _buildActionButtons(
    BookingModel booking,
    BookingController bookingController,
  ) {
    /// ✅ إذا ملغي
    if (booking.status == BookingStatus.canceled) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Canceled',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    /// ⏳ غير ملغي
    return Row(
      children: [
        /// ✏️ Edit
        Expanded(
          child: ElevatedButton(
            onPressed: _canEditBooking(booking)
                ? () {
                    Get.toNamed(
                      '/editBooking',
                      arguments: booking,
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),

        /// ❌ Cancel
        Expanded(
          child: ElevatedButton(
            onPressed:_canEditBooking(booking)? () {
              Get.defaultDialog(
                title: 'Cancel Booking',
                middleText:
                    'Are you sure you want to cancel this booking?',
                textCancel: 'No',
                textConfirm: 'Yes, Cancel',
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                onConfirm: () {
                  bookingController.cancelBooking(booking.id);
                  Get.back();
                  Get.back();
                },
              );
            } :null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔒 منع التعديل إذا الحجز بلّش
  bool _canEditBooking(BookingModel booking) {
    final today = DateTime.now();
    final startDateOnly = DateTime(
      booking.startDate.year,
      booking.startDate.month,
      booking.startDate.day,
    );

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    return startDateOnly.isAfter(todayOnly) &&
        booking.status == BookingStatus.current;
  }

  Widget _infoItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
void _showRatingDialog(
  BookingModel booking,
  BookingController controller,
) {
  final rating = 1.0.obs;
  final commentController = TextEditingController();

  Get.defaultDialog(
    title: 'Rate Apartment',
    content: Column(
      children: [
        Obx(
          () => Slider(
            value: rating.value,
            min: 1,
            max: 5,
            divisions: 4,
            label: rating.value.toString(),
            onChanged: (value) {
              rating.value = value;
            },
          ),
        ),
      ],
    ),
    textConfirm: 'Submit',
    confirmTextColor: Colors.white,
    buttonColor: Colors.amber,
    onConfirm: () {
      controller.addRating(
        booking.id,
        rating.value,
        commentController.text.isEmpty
            ? null
            : commentController.text,
      );
      Get.back();
    },
    textCancel: 'Cancel',
  );
}
