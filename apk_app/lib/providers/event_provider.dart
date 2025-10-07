import 'package:flutter/material.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [
    Event(
      id: '1',
      name: 'Fiesta Electro Underground',
      description: 'Una noche llena de beats electrónicos en el corazón de la ciudad.',
      address: 'Calle Ficticia 123, Ciudad',
      latitude: -34.6037,
      longitude: -58.3816,
      ticketPrice: 15.0,
      images: ['https://via.placeholder.com/200'],
      rating: 4.5,
      ratingCount: 10,
      date: DateTime.now().add(Duration(days: 7)),
      organizerId: '1',
    ),
    Event(
      id: '2',
      name: 'Concierto Banda Indie',
      description: 'Descubre nuevos talentos en la escena indie.',
      address: 'Plaza Central, Ciudad',
      latitude: -34.6037,
      longitude: -58.3816,
      ticketPrice: 10.0,
      images: ['https://via.placeholder.com/200'],
      rating: 4.0,
      ratingCount: 5,
      date: DateTime.now().add(Duration(days: 14)),
      organizerId: '1',
    ),
  ];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    // Ya tenemos datos mock
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    _events.add(event);
    notifyListeners();
  }

  Future<void> updateEvent(Event event) async {
    int index = _events.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _events[index] = event;
      notifyListeners();
    }
  }
}