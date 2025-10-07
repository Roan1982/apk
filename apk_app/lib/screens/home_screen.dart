import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../models/event.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventos Underground')),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          return ListView.builder(
            itemCount: eventProvider.events.length,
            itemBuilder: (context, index) {
              Event event = eventProvider.events[index];
              return ListTile(
                title: Text(event.name),
                subtitle: Text(event.description),
                onTap: () {
                  Navigator.pushNamed(context, '/event_detail', arguments: event);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_event');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}