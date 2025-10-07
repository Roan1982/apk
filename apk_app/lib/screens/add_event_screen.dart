import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/event_provider.dart';
import '../models/event.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  List<String> _images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Subir a Firebase Storage
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance.ref().child('event_images/$fileName');
        UploadTask uploadTask = ref.putFile(File(image.path));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _images.add(downloadUrl);
        });
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al subir la imagen')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Evento')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Precio Entrada'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'Latitud'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'Longitud'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Seleccionar Imagen'),
              ),
              Wrap(
                children: _images.map((imageUrl) => Image.network(imageUrl, width: 100, height: 100)).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Validar entradas
                  if (_nameController.text.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      _addressController.text.isEmpty ||
                      _priceController.text.isEmpty ||
                      _latitudeController.text.isEmpty ||
                      _longitudeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, completa todos los campos')),
                    );
                    return;
                  }

                  double? price;
                  double? lat;
                  double? lng;
                  try {
                    price = double.parse(_priceController.text);
                    lat = double.parse(_latitudeController.text);
                    lng = double.parse(_longitudeController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, ingresa números válidos')),
                    );
                    return;
                  }

                  // Crear evento
                  Event event = Event(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    description: _descriptionController.text,
                    address: _addressController.text,
                    latitude: lat,
                    longitude: lng,
                    ticketPrice: price,
                    images: _images.isEmpty ? ['https://via.placeholder.com/200'] : _images,
                    rating: 0.0,
                    ratingCount: 0,
                    date: DateTime.now(),
                    organizerId: Provider.of<AuthProvider>(context, listen: false).user!.id,
                  );
                  await Provider.of<EventProvider>(context, listen: false).addEvent(event);
                  Navigator.pop(context);
                },
                child: Text('Agregar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}