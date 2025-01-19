import 'package:calendar/src/screens/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalendarApp',
      theme: ThemeData(useMaterial3: true),
      home: const CalendarScreen(),
    );
  }
}
