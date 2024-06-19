import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/event_controller.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'edit_event_screen.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      List<Event> fetchedEvents = await EventController.fetchEvents();
      setState(() {
        events = fetchedEvents;
      });
    } catch (e) {
      print('Error fetching events: $e');
      // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 73, 143, 75),
        title: Text(
          'Event Schedule',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.month;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.view_week, color: Colors.white),
            onPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.week;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.date_range, color: Colors.white),
            onPressed: () {
              setState(() {
                _calendarFormat = CalendarFormat.twoWeeks;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: (day) {
              return events
                  .where((event) => _isSameDay(event.startAt, day))
                  .toList();
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            selectedDayPredicate: (day) {
              return _isSameDay(_selectedDay, day);
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 143, 75),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 176, 214, 177),
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _selectedDay != null
                ? _buildEventsOrError(_selectedDay!)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/select.gif'),
                        Text(
                          'Select a date to view events',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime? a, DateTime b) {
    return a?.year == b.year && a?.month == b.month && a?.day == b.day;
  }

  Widget _buildEventsOrError(DateTime selectedDay) {
    List<Event> filteredEvents = events
        .where((event) => _isSameDay(event.startAt, selectedDay))
        .toList();

    if (filteredEvents.isNotEmpty) {
      return ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          final event = filteredEvents[index];
          return EventCard(
            event: event,
            editEventCallback: () {
              _editEvent(event);
            },
            deleteEventCallback: () {
              _deleteEvent(event);
            },
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/noevents.gif'),
            Text(
              'No events found for ${DateFormat('dd-MM-yyyy').format(selectedDay)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }

  void _editEvent(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditEventScreen(event: event)),
    ).then((editedEvent) {
      if (editedEvent != null) {
        setState(() {
          int index = events.indexWhere((e) => e.id == editedEvent.id);
          if (index != -1) {
            events[index] = editedEvent;
          }
        });
      }
    });
  }

  void _deleteEvent(Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Event'),
          content: Text('Are you sure you want to delete this event?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  events.removeWhere((e) => e.id == event.id);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
