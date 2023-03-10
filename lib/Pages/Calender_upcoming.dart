import 'package:flutter/material.dart';
import 'package:flutter_catalog/model/Meeting.dart';
import 'package:flutter_catalog/model/Meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalenderWidget> {
  Future<List<Meeting>> _getDataSource() async {
    final url = Uri.parse('http://194.116.228.5:130/Api/UPComAgenda/GetAll/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final meetings = data
          .map((item) => Meeting(
              item['meeting'],
              DateTime.parse(item['tdate']),
              DateTime.parse(item['tdate']).add(Duration(hours: 6)),
              Color.fromARGB(255, 28, 44, 92),
              false))
          .toList();
      return meetings;
    } else {
      throw Exception('Failed to load meetings');
    }
  }
  // List<Meeting> _getDataSource() {
  //   final List<Meeting> meeting = <Meeting>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime =
  //       DateTime(today.year, today.month, today.day, 9, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 6));

  //   meeting.add(Meeting(
  //       'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  //   meeting.add(Meeting(
  //       'IT Director Meetings',
  //       startTime.add(Duration(days: 7)),
  //       endTime.add(Duration(days: 7)),
  //       Color.fromARGB(255, 27, 6, 121),
  //       false));
  //   meeting.add(Meeting(
  //       'Job Schedule',
  //       startTime.add(Duration(days: 15)),
  //       endTime.add(Duration(days: 15)),
  //       Color.fromARGB(255, 4, 43, 46),
  //       false));

  //   return meeting;
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'SIAL Corporate Affairs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Meeting>>(
        future: _getDataSource(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfCalendar(
              appointmentTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              todayHighlightColor: Theme.of(context).colorScheme.primary,
              view: CalendarView.month,
              cellBorderColor: Colors.transparent,
              dataSource: MeetingDataSource(snapshot.data!),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Something went wrong'));
          } else {
            return Center(
                child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.primary,
              ),
            ));
          }
        },
      ),
      // drawer: MyDrawer(),
    );
    //     body: SfCalendar(
    //       view: CalendarView.month,
    //       cellBorderColor: Colors.transparent,
    //       dataSource: MeetingDataSource(_getDataSource()),
    //       monthViewSettings: MonthViewSettings(
    //           appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
    //           showAgenda: true),

    //     ),
    //     drawer: MyDrawer(),
    //   ),
    // );
  }
}

// List<Appointment> getAppointments() {
//   List<Appointment> meetings = <Appointment>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Appointment(
//       startTime: startTime,
//       endTime: endTime,
//       subject: 'IT ',
//       color: Colors.blue,
//       recurrenceRule: 'FREQ=DAILY;COUNT=10',
//       isAllDay: true));
//   return meetings;
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
