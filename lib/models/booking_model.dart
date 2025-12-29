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
    return BookingModel(
      id: json['id'].toString(),
      apartment: ApartmentModel.fromJson(json['apartment']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalPrice: double.tryParse(json['total_price'].toString()),
      // تحويل الـ String القادم من Laravel إلى Enum الخاص بك
      status: _mapStatus(json['status']),
      // إذا كان هناك تقييم مرتبط بالحجز في Laravel
      rating: json['rating'] != null ? RatingModel.fromJson(json['rating']) : null,
    );
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
