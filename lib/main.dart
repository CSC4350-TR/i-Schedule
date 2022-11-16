///import 'dart:html';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:calendar_project/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calender Project",
      home: Calendar(),
    );
  }
}
