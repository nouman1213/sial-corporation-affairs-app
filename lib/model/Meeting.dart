import 'package:flutter/material.dart';

class Meeting {
  Meeting(this.EventName, this.from, this.to, this.Background, this.isAllDay);

  String EventName;
  DateTime from;
  DateTime to;
  Color Background;
  bool isAllDay;
}
