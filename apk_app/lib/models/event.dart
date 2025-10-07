class Event {
  final String id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double ticketPrice;
  final List<String> images;
  final double rating;
  final int ratingCount;
  final DateTime date;
  final String organizerId;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.ticketPrice,
    required this.images,
    required this.rating,
    required this.ratingCount,
    required this.date,
    required this.organizerId,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      ticketPrice: map['ticketPrice'],
      images: List<String>.from(map['images']),
      rating: map['rating'],
      ratingCount: map['ratingCount'],
      date: DateTime.parse(map['date']),
      organizerId: map['organizerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'ticketPrice': ticketPrice,
      'images': images,
      'rating': rating,
      'ratingCount': ratingCount,
      'date': date.toIso8601String(),
      'organizerId': organizerId,
    };
  }
}