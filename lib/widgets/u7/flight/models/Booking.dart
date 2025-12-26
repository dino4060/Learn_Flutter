import 'package:flutter_application_1/widgets/u7/flight/models/Flight.dart';

enum BookingStatus { upcoming, cancelled }

class Booking {
  final int id;
  final Flight flight;
  final int tickets;
  final bool isRoundTrip;
  final double totalPrice;
  final DateTime bookingDate;
  BookingStatus status;

  Booking({
    required this.id,
    required this.flight,
    required this.tickets,
    required this.isRoundTrip,
    required this.totalPrice,
    required this.bookingDate,
    this.status = BookingStatus.upcoming,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      flight: Flight.fromJson(json['flight']),
      tickets: json['tickets'],
      isRoundTrip: json['isRoundTrip'],
      totalPrice: json['totalPrice'].toDouble(),
      bookingDate: DateTime.parse(json['bookingDate']),
      status: BookingStatus.values[json['status']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flight': flight.toJson(),
      'tickets': tickets,
      'isRoundTrip': isRoundTrip,
      'totalPrice': totalPrice,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status.index,
    };
  }
}
