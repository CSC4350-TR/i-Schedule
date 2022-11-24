import 'package:calendar_project/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController starttimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Project"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2990),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Add Event"),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  TextFormField(
                    controller: _eventController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: "Date",
                    ),
                  ),
                  TextFormField(
                    controller: starttimeController,
                    decoration: const InputDecoration(
                      labelText: "Start Time",
                    ),
                  ),
                  TextFormField(
                    controller: endtimeController,
                    decoration: const InputDecoration(
                      labelText: "End Time",
                    ),
                  ),
                  TextFormField(
                    controller: recipientController,
                    decoration: const InputDecoration(
                      labelText: "Invitee",
                    ),
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
                    ),
                  ),
                  TextFormField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      labelText: "Comments",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text("Save Event"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: const Text("Add Event"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
