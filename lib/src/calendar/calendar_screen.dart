import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2024年12月'),
      ),
      body: const CalendarView(),
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Column(
      children: [
        const Row(
          children: [
            DayOfWeekCell(dayName: '日', style: TextStyle(color: Colors.red)),
            DayOfWeekCell(dayName: '月'),
            DayOfWeekCell(dayName: '火'),
            DayOfWeekCell(dayName: '水'),
            DayOfWeekCell(dayName: '木'),
            DayOfWeekCell(dayName: '金'),
            DayOfWeekCell(dayName: '土', style: TextStyle(color: Colors.blue)),
          ],
        ),
        const Row(
          children: [
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
          ],
        ),
        const Row(
          children: [
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
            DayCell("a"),
          ],
        ),
        Text(now.timeZoneName),
      ],
    );
  }
}

// 曜日表示
class DayOfWeekCell extends StatelessWidget {
  final String dayName;
  final TextStyle? style;
  const DayOfWeekCell({super.key, required this.dayName, this.style});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        dayName,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DayCell extends StatelessWidget {
  final String day;
  final TextStyle? style;
  const DayCell(this.day, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "day",
            style: style,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
