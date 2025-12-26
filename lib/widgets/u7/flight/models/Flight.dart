class Flight {
  final int id;
  final String from;
  final String to;
  final String time;
  final double price;
  final String airline;
  final String flightNumber;

  Flight({
    required this.id,
    required this.from,
    required this.to,
    required this.time,
    required this.price,
    required this.airline,
    required this.flightNumber,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      time: json['time'],
      price: json['price'].toDouble(),
      airline: json['airline'],
      flightNumber: json['flightNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'time': time,
      'price': price,
      'airline': airline,
      'flightNumber': flightNumber,
    };
  }
}
