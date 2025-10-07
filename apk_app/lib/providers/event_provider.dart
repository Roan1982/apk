import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('events').get();
      _events = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Agregar el ID del documento
        return Event.fromMap(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching events: $e');
      // Mantener eventos vacíos o manejar error
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      DocumentReference docRef = await _firestore.collection('events').add(event.toMap());
      // Actualizar el ID del evento con el ID generado por Firestore
      Event newEvent = Event(
        id: docRef.id,
        name: event.name,
        description: event.description,
        address: event.address,
        latitude: event.latitude,
        longitude: event.longitude,
        ticketPrice: event.ticketPrice,
        images: event.images,
        rating: event.rating,
        ratingCount: event.ratingCount,
        date: event.date,
        organizerId: event.organizerId,
      );
      _events.add(newEvent);
      notifyListeners();
    } catch (e) {
      print('Error adding event: $e');
      throw e;
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await _firestore.collection('events').doc(event.id).update(event.toMap());
      int index = _events.indexWhere((e) => e.id == event.id);
      if (index != -1) {
        _events[index] = event;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating event: $e');
      throw e;
    }
  }
}