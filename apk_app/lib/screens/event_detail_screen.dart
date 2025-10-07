import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../models/event.dart';

class EventDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(title: Text(event.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imágenes
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: event.images.length,
                itemBuilder: (context, index) {
                  String imageUrl = event.images[index];
                  if (imageUrl.startsWith('http')) {
                    return Image.network(imageUrl, width: 200, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(width: 200, color: Colors.grey, child: Icon(Icons.image)));
                  } else {
                    return Image.file(File(imageUrl), width: 200, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(width: 200, color: Colors.grey, child: Icon(Icons.image)));
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.description),
                  SizedBox(height: 10),
                  Text('Dirección: ${event.address}'),
                  Text('Precio entrada: \$${event.ticketPrice}'),
                  Text('Fecha: ${event.date.toString()}'),
                  SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: event.rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                  ),
                  Text('${event.ratingCount} ratings'),
                  SizedBox(height: 20),
                  // Mapa
                  Container(
                    height: 200,
                    child: Center(child: Text('Mapa no disponible. Coordenadas: ${event.latitude}, ${event.longitude}')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}