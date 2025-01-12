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
              const DayCell(null),
            ],
          ),
          Text(firstDayOfMonth.weekday.toString())
        ],
      ),
    );
  }

  List<String?> makeDaysOfMonth() {
    List<String?> monthDaysStrings = [];
    final weekdayOfFirstDay =
        firstDayOfMonth.weekday; // 日0,月1,火2,水3,木4,金5,土6が入る

    // 最初の日付が始まる曜日までnullで埋める
    for (int i = 0; i < weekdayOfFirstDay; i++) {
      monthDaysStrings.add(null);
    }

    // 当月の日付を入力していく
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      monthDaysStrings.add(i.toString());
    }

    // 月末の曜日から土曜日まで空いている分をnullで埋める
    for (int i = lastDayOfMonth.weekday + 1; i <= 6; i++) {
      monthDaysStrings.add(null);
    }
    return monthDaysStrings;
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
  final String? day;
  final TextStyle? style;
  const DayCell(this.day, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    const double height = 30;
    if (day != null) {
      return Expanded(
        child: Column(
          children: [
            Text(
              day!,
              style: style,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: height,
            )
          ],
        ),
      );
    }
    return Expanded(
      child: Container(
        height: height,
        color: Colors.black38,
      ),
    );
  }
}
