import 'package:bookingresidentialapartments/models/rating_model.dart';

import '../models/apartment_model.dart';

enum BookingStatus { all, current, previous, canceled }

class BookingModel {
  final String id;
  final ApartmentModel apartment;
   DateTime startDate;
   DateTime endDate;
   BookingStatus status;
  RatingModel? rating;
  BookingModel({
    required this.id,
    required this.apartment,
    required this.startDate,
    required this.endDate,
    this.status = BookingStatus.current,
    this.rating,
  });
  bool get isFinished =>
      endDate.isBefore(DateTime.now());

 bool get canRate {
  final today = DateTime.now();

  return status == BookingStatus.previous &&
      rating == null &&
      endDate.isBefore(today);
}
}
