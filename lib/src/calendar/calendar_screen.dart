import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  late DateTime now;
  late int month;
  late int year;
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    super.initState();

    // 初期状態は今日の日付
    now = DateTime.now();
    month = now.month;
    year = now.year;
    firstDayOfMonth = DateTime(year, month, 1);
    lastDayOfMonth = DateTime(year, month + 1, 0); // 次の月の0日目(今月の最終日)取得
  }

  @override
  Widget build(BuildContext context) {
    print(now.day);
    return Scaffold(
      appBar: AppBar(
        title: Text("$year年$month月"),
      ),
      body: Column(
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
          Row(
            children: [
              DayCell(now.day.toString()),
            ],
          ),
          Text(firstDayOfMonth.weekday.toString())
        ],
      ),
    );
  }

  List<String?> makeMonthsDays() {
    List<String?> monthDays = [];
    final weekdayOfFirstDay =
        firstDayOfMonth.weekday; // 日0,月1,火2,水3,木4,金5,土6が入る

    // 最初の日付が始まる曜日までnullで埋める
    for (int i = 0; i < weekdayOfFirstDay; i++) {
      monthDays.add(null);
    }

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      monthDays.add(i.toString());
    }
    print(monthDays);
    return monthDays;
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

// 日付単体のセル
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
            day,
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
