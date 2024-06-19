import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';


class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback editEventCallback;
  final VoidCallback deleteEventCallback;

  EventCard({
    required this.event,
    required this.editEventCallback,
    required this.deleteEventCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromARGB(255, 244, 245, 244),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        event.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        editEventCallback(); 
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                event.description,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8.0),
              (event.status == 'Cancelled')
                  ? Row(
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          event.status,
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Icon(
                          Icons.assignment_turned_in_outlined,
                          size: 20,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          event.status,
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.date_range, size: 20, color: Colors.blue),
                  SizedBox(width: 8.0),
                  Text(
                    '${DateFormat('dd-MM-yyyy').format(event.startAt)}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.schedule, size: 20),
                  SizedBox(width: 8.0),
                  Text(
                    '${DateFormat('HH:mm').format(event.startAt)} - ${event.duration}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, 
                    ),
                    onPressed: () {
                      deleteEventCallback(); 
                    },
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8), 
                        Text('Delete', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
