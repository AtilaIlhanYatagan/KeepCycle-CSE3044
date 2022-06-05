import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/alarm_repository.dart';
import 'alarm_edit_screen.dart';

class SupplementReminder extends ConsumerWidget {
  const SupplementReminder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmRepository = ref.watch(alarmListProvider);
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        title: const Text('Supplement Countdown'),
      ),
      body: alarmRepository.hasAdded
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    for (final alarm in alarmRepository.alarmList)
                      AlarmWidget(alarm: alarm),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text(
                'No alarm',
                style: TextStyle(fontSize: 40),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final alarmProperties = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AlarmEditScreen();
              },
            ),
          );

          final alarm = Alarm(alarmProperties[0], alarmProperties[1]);
          ref.read(alarmListProvider).addAlarm(alarm);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AlarmWidget extends ConsumerStatefulWidget {
  final Alarm alarm;

  const AlarmWidget({Key? key, required this.alarm}) : super(key: key);

  @override
  ConsumerState<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends ConsumerState<AlarmWidget> {
  Duration duration = const Duration();
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    setReset();
  }

  void editAlarm(List a) {
    setState(() {
      widget.alarm.alarmHeader = a.first.toString();
      timer?.cancel();
      duration = Duration(hours: int.parse(a.last.toString()));
      isRunning = false;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    setState(() {
      isRunning = true;
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void setReset() {
    setState(() {
      timer?.cancel();
      duration = Duration(hours: int.parse(widget.alarm.alarmDuration));
      isRunning = false;
    });
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
        setReset();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 200.0,
          width: 350.0,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(
                colors: [Colors.indigo, Colors.blueAccent]),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      widget.alarm.alarmHeader,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTime(),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isRunning
                            ? Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: const Icon(Icons.pause),
                                        color: Colors.white,
                                        onPressed: () {
                                          stopTimer();
                                        },
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: IconButton(
                                        icon: const Icon(Icons.restart_alt),
                                        color: Colors.white,
                                        onPressed: () {
                                          setReset();
                                        },
                                      )),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  icon: const Icon(Icons.play_arrow_rounded),
                                  color: Colors.white,
                                  onPressed: () {
                                    startTimer();
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () async {
                              final List newAlarmValues =
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                builder: (context) {
                                  return AlarmEditScreen();
                                },
                              ));
                              editAlarm(newAlarmValues);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(''),
                                  content: const Text('Deleting alarm'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Delete'),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value == 'Delete') {
                                  ref
                                      .read(alarmListProvider)
                                      .removeAlarm(widget.alarm);
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            time,
            style: const TextStyle(fontSize: 50),
          ),
        ),
        Text(header,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red.shade300))
      ],
    );
  }
}
