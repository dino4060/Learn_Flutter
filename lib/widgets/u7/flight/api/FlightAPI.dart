import 'package:flutter_application_1/widgets/u7/flight/models/Booking.dart';
import 'package:flutter_application_1/widgets/u7/flight/models/Flight.dart';

class FlightAPI {
  static final List<Booking> bookings = [];

  static final List<Flight> mockData = [
    Flight(
      id: 1,
      from: "Hà Nội",
      to: "TP. Hồ Chí Minh",
      time: "06:00 - 08:15",
      price: 1500000,
      airline: "Vietnam Airlines",
      flightNumber: "VN210",
    ),
    Flight(
      id: 2,
      from: "Hà Nội",
      to: "TP. Hồ Chí Minh",
      time: "09:30 - 11:45",
      price: 1800000,
      airline: "Vietjet Air",
      flightNumber: "VJ123",
    ),
    Flight(
      id: 3,
      from: "Hà Nội",
      to: "TP. Hồ Chí Minh",
      time: "14:00 - 16:15",
      price: 1650000,
      airline: "Bamboo Airways",
      flightNumber: "QH207",
    ),
    Flight(
      id: 4,
      from: "Hà Nội",
      to: "TP. Hồ Chí Minh",
      time: "18:30 - 20:45",
      price: 2000000,
      airline: "Vietnam Airlines",
      flightNumber: "VN218",
    ),
    Flight(
      id: 5,
      from: "TP. Hồ Chí Minh",
      to: "Hà Nội",
      time: "07:00 - 09:15",
      price: 1550000,
      airline: "Vietjet Air",
      flightNumber: "VJ124",
    ),
    Flight(
      id: 6,
      from: "TP. Hồ Chí Minh",
      to: "Hà Nội",
      time: "10:30 - 12:45",
      price: 1750000,
      airline: "Bamboo Airways",
      flightNumber: "QH208",
    ),
    Flight(
      id: 7,
      from: "TP. Hồ Chí Minh",
      to: "Hà Nội",
      time: "15:00 - 17:15",
      price: 1900000,
      airline: "Vietnam Airlines",
      flightNumber: "VN211",
    ),
    Flight(
      id: 8,
      from: "TP. Hồ Chí Minh",
      to: "Hà Nội",
      time: "19:30 - 21:45",
      price: 2100000,
      airline: "Vietjet Air",
      flightNumber: "VJ125",
    ),
    Flight(
      id: 9,
      from: "Hà Nội",
      to: "Đà Nẵng",
      time: "08:00 - 09:30",
      price: 900000,
      airline: "Vietnam Airlines",
      flightNumber: "VN130",
    ),
    Flight(
      id: 10,
      from: "Hà Nội",
      to: "Đà Nẵng",
      time: "13:00 - 14:30",
      price: 950000,
      airline: "Vietjet Air",
      flightNumber: "VJ140",
    ),
    Flight(
      id: 11,
      from: "Đà Nẵng",
      to: "Hà Nội",
      time: "10:00 - 11:30",
      price: 920000,
      airline: "Bamboo Airways",
      flightNumber: "QH150",
    ),
    Flight(
      id: 12,
      from: "Đà Nẵng",
      to: "Hà Nội",
      time: "16:00 - 17:30",
      price: 980000,
      airline: "Vietnam Airlines",
      flightNumber: "VN131",
    ),
    Flight(
      id: 13,
      from: "TP. Hồ Chí Minh",
      to: "Đà Nẵng",
      time: "07:30 - 09:00",
      price: 850000,
      airline: "Vietjet Air",
      flightNumber: "VJ160",
    ),
    Flight(
      id: 14,
      from: "TP. Hồ Chí Minh",
      to: "Đà Nẵng",
      time: "12:00 - 13:30",
      price: 900000,
      airline: "Bamboo Airways",
      flightNumber: "QH170",
    ),
    Flight(
      id: 15,
      from: "Đà Nẵng",
      to: "TP. Hồ Chí Minh",
      time: "09:30 - 11:00",
      price: 870000,
      airline: "Vietnam Airlines",
      flightNumber: "VN180",
    ),
    Flight(
      id: 16,
      from: "Đà Nẵng",
      to: "TP. Hồ Chí Minh",
      time: "14:30 - 16:00",
      price: 920000,
      airline: "Vietjet Air",
      flightNumber: "VJ161",
    ),
    Flight(
      id: 17,
      from: "Hà Nội",
      to: "Nha Trang",
      time: "06:30 - 09:00",
      price: 1400000,
      airline: "Vietnam Airlines",
      flightNumber: "VN190",
    ),
    Flight(
      id: 18,
      from: "Nha Trang",
      to: "Hà Nội",
      time: "10:00 - 12:30",
      price: 1450000,
      airline: "Vietjet Air",
      flightNumber: "VJ200",
    ),
    Flight(
      id: 19,
      from: "TP. Hồ Chí Minh",
      to: "Phú Quốc",
      time: "08:00 - 09:15",
      price: 1100000,
      airline: "Bamboo Airways",
      flightNumber: "QH220",
    ),
    Flight(
      id: 20,
      from: "Phú Quốc",
      to: "TP. Hồ Chí Minh",
      time: "11:00 - 12:15",
      price: 1150000,
      airline: "Vietnam Airlines",
      flightNumber: "VN230",
    ),
  ];

  static Future<List<Flight>> searchFlights(String from, String to) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockData.where((f) => f.from == from && f.to == to).toList();
  }

  static Future<bool> bookFlight(
    Flight flight,
    int tickets,
    bool isRoundTrip,
    double totalPrice,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch,
      flight: flight,
      tickets: tickets,
      isRoundTrip: isRoundTrip,
      totalPrice: totalPrice,
      bookingDate: DateTime.now(),
    );

    bookings.add(booking);
    return true;
  }

  static Future<List<Booking>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(bookings);
  }

  static void cancelBooking(int bookingId) {
    final index = bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      bookings[index].status = BookingStatus.cancelled;
    }
  }

  static List<String> getCities() {
    final cities = <String>{};
    for (var flight in mockData) {
      cities.add(flight.from);
      cities.add(flight.to);
    }
    return cities.toList()..sort();
  }
}
