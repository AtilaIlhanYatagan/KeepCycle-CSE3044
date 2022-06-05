import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmRepository extends ChangeNotifier {
  final List<Alarm> alarmList = [];
  bool hasAdded = false;

  void addAlarm(Alarm newAlarm) {
    alarmList.add(newAlarm);
    hasAdded = true;
    notifyListeners();
  }

  void removeAlarm(Alarm removedAlarm) {
    if (alarmList.length == 1){
      hasAdded = false;
    }
    alarmList.remove(removedAlarm);
    notifyListeners();
  }
}

final alarmListProvider = ChangeNotifierProvider((ref) {
  return AlarmRepository();
});

class Alarm {
  String alarmHeader;
  String alarmDuration;

  Alarm(this.alarmHeader, this.alarmDuration);
}