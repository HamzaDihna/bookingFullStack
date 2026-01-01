import 'package:bookingresidentialapartments/models/rating_model.dart';

import '../models/apartment_model.dart';

enum BookingStatus { all, current, previous, canceled,}

class BookingModel {
  final String id;
  final ApartmentModel apartment;
   DateTime startDate;
   DateTime endDate;
   BookingStatus status;
  RatingModel? rating;
  double? totalPrice;
  BookingModel({
    required this.id,
    required this.apartment,
    required this.startDate,
    required this.endDate,
    this.status = BookingStatus.current,
    this.totalPrice,
    this.rating,
  });
  factory BookingModel.fromJson(Map<String, dynamic> json) {
     final start = DateTime.parse(json['start_date']);
  final end = DateTime.parse(json['end_date']);

  final initialStatus = _mapStatus(json['status']);

  final finalStatus = _calculateStatus(
    start,
    end,
    initialStatus,
  );
    return BookingModel(
      id: json['id'].toString(),
    apartment: ApartmentModel.fromJson(json['apartment']),
    startDate: start,
    endDate: end,
    totalPrice: double.tryParse(json['total_price'].toString()),
    status: finalStatus,
      // إذا كان هناك تقييم مرتبط بالحجز في Laravel
      rating: json['rating'] != null ? RatingModel.fromJson(json['rating']) : null,
    );
  }
static BookingStatus _calculateStatus(
  DateTime start,
  DateTime end,
  BookingStatus backendStatus,
) {
  if (backendStatus == BookingStatus.canceled) {
    return BookingStatus.canceled;
  }

  final today = DateTime.now();
  final todayOnly = DateTime(today.year, today.month, today.day);

  final endOnly = DateTime(end.year, end.month, end.day);

  if (endOnly.isBefore(todayOnly)) {
    return BookingStatus.previous;
  }

  return BookingStatus.current;
}

  // دالة مساعدة لتحويل نصوص Laravel إلى Enum تطبيقك
  static BookingStatus _mapStatus(String status) {
    switch (status) {
      case 'approved': return BookingStatus.current;
      case 'pending': return BookingStatus.current;
      case 'cancelled':
      case 'rejected': return BookingStatus.canceled;
      default: return BookingStatus.previous;
    }
  }
  bool get isFinished =>
      endDate.isBefore(DateTime.now());

 bool get canRate {
  final today = DateTime.now();

  return status == BookingStatus.previous &&
      rating == null &&
      endDate.isBefore(today);
}
}
