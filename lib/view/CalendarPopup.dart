import 'package:flutter/material.dart';
import 'package:papas/model/DiaryModel.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPopup extends StatefulWidget {
  final List<Diary> diaryList;
  CalendarPopup({super.key, required this.diaryList});

  @override
  State<CalendarPopup> createState() => _CalendarPopupState();
}

class _CalendarPopupState extends State<CalendarPopup> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  Map<DateTime, List<Diary>> _events = {};

  @override
  void initState() {
    super.initState();
    _updateEvents();
  }

  void _updateEvents() {
    _events = {};
    for (Diary diary in widget.diaryList) {
      DateTime date = DateTime.parse(diary.date);
      _events.update(date, (value) => [...value, diary], ifAbsent: () => [diary]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 24.0),
                child: Text('기록된 다이어리', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),)
            ),
            TableCalendar(
              locale: 'ko_KR',
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2099, 12, 31),
              calendarFormat: _calendarFormat,
              daysOfWeekHeight: 30, // 요일과 일자 사이 간격
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFFB9BADA),
                  shape: BoxShape.circle
                ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFFD2B9D6),
                    shape: BoxShape.circle,
                  )
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              // 사용자가 캘린더에 해당일을 클릭했을 때
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  DateTime _date = DateTime(date.year, date.month, date.day);
                  if (_events[_date] != null) {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.11,
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFF3DA),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              ),
            ),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pop(); // 팝업 닫기
            //   },
            //   child: Text('OK'),
            // ),
          ],
        ),
    );
  }
}
