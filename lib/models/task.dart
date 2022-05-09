import 'package:flutter/widgets.dart';

class Task {
  int? id;
  String? title;
  String? description;
  DateTime? time;
  String? startTime;
  String? endTime;

  Task(this.title, this.description, this.time, this.startTime, this.endTime);

  Task.withId(this.id, this.title, this.description, this.time, this.startTime,
      this.endTime);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "title": title,
      "description": description,
      "time": time?.toIso8601String(),
      "startTime": startTime,
      "endTime": endTime
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Task.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?)!;
    title = (map["title"] as String?)!;
    description = (map["description"] as String?)!;
    time = (DateTime.tryParse(map["time"] as String))!;
    startTime = (map["startTime"] as String?)!;
    endTime = (map["endTime"] as String?)!;
  }
}
