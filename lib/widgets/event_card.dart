import 'package:flutter/material.dart';
import '../models/event.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  EditEventScreen({required this.event});

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController =
        TextEditingController(text: widget.event.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Color for the back button icon
        ),
        backgroundColor: Color.fromARGB(255, 73, 143, 75),
        title: Text(
          'Edit Event',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              cursorColor: Color.fromARGB(255, 73, 143, 75),
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Color.fromARGB(255, 73, 143, 75)),
                floatingLabelStyle:
                    TextStyle(color: Color.fromARGB(255, 73, 143, 75)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 73, 143, 75)),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              cursorColor: Color.fromARGB(255, 73, 143, 75),
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Color.fromARGB(255, 73, 143, 75)),
                floatingLabelStyle:
                    TextStyle(color: Color.fromARGB(255, 73, 143, 75)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 73, 143, 75)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Event updatedEvent = Event(
                      id: widget.event.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      status: widget.event.status,
                      startAt: widget.event.startAt,
                      duration: widget.event.duration,
                    );

                    Navigator.pop(context, updatedEvent);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(
                        255, 73, 143, 75), // Text color of the button
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
