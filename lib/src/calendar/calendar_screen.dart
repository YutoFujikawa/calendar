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
    changeCalendarDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$year年$month月"),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: previousMonth,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: nextMonth,
          ),
        ],
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
          Flexible(
            // FIXME(): grid間に微妙な白線が入る。
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount:
                  42, // FIXME(): 1日が金土とかに始まると最大42マス必要だけど、大体35マスで収まることが多く、下の行があまりがち
              itemBuilder: (context, index) {
                List<String?> daysOfMonth = makeDaysOfMonth();

                if (index < daysOfMonth.length && daysOfMonth[index] != null) {
                  return DayCell(daysOfMonth[index]);
                } else {
                  return const DayCell(null);
                }
              },
            ),
          ),
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

  void previousMonth() {
    setState(() {
      if (month == 1) {
        year -= 1;
        month = 12;
      } else {
        month -= 1;
      }
      changeCalendarDay();
    });
  }

  void nextMonth() {
    setState(() {
      if (month == 12) {
        year += 1;
        month = 1;
      } else {
        month += 1;
      }
      changeCalendarDay();
    });
  }

  void changeCalendarDay() {
    firstDayOfMonth = DateTime(year, month, 1);
    lastDayOfMonth = DateTime(year, month + 1, 0); // 次の月の0日目(今月の最終日)取得
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey), // 枠線を追加
      ),
      child: day != null
          ? Column(
              children: [
                Text(
                  day!,
                  style: style,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: height)
              ],
            )
          : Container(
              height: height,
              color: Colors.grey,
            ),
    );
  }
}
