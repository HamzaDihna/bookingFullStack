import '../models/apartment_model.dart';

enum BookingStatus { all, current, previous, canceled }

class BookingModel {
  final String id;
  final ApartmentModel apartment;
  final DateTime startDate;
  final DateTime endDate;
   BookingStatus status;

  BookingModel({
    required this.id,
    required this.apartment,
    required this.startDate,
    required this.endDate,
    this.status = BookingStatus.current,
  });
}