//TODO edit yapıldığında yeni değerle başlaması lazım
import 'dart:async';

import 'package:flutter/material.dart';

class SupplementReminder extends StatefulWidget {
  const SupplementReminder({
    Key? key,
  }) : super(key: key);

  @override
  State<SupplementReminder> createState() => _SupplementReminderState();
}

class _SupplementReminderState extends State<SupplementReminder> {
  List<Alarm> alarmList = [];
  Alarm? lastAddedAlarm;
  bool hasAdded = false;

  void addAlarm(Alarm newAlarm) {
    setState(() {
      alarmList = [...alarmList, newAlarm];
    });
  }

  void removeAlarm() {
    setState(() {
      if (alarmList.isEmpty) {
        hasAdded = false;
      } else {
        if (alarmList.length == 1) {
          alarmList = [];
          hasAdded = false;
        } else {
          lastAddedAlarm = alarmList[alarmList.length - 2] as Alarm?;
          alarmList.length = alarmList.length - 2;
          alarmList = [...alarmList, lastAddedAlarm!];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        title: const Text('Supplement Countdown'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              for (final alarm in alarmList) alarm,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final alarmProperties =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AlarmEditScreen();
            },
          ));
          addAlarm(Alarm(
              alarmHeader: alarmProperties[0],
              alarmDuration: alarmProperties[1]));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Alarm extends StatefulWidget {
  String alarmHeader;
  String alarmDuration;

  Alarm({
    Key? key,
    required this.alarmHeader,
    required this.alarmDuration,
  }) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  Duration duration = Duration();
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    setReset();
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
      duration = Duration(hours: int.parse(widget.alarmDuration));
      isRunning=false;
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
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0))
              ]),
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
                      widget.alarmHeader,
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
                    isRunning ? Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: IconButton(
                              icon: const Icon(Icons.pause),
                              color: Colors.white,
                              onPressed: ()  {
                              stopTimer();
                              },
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: IconButton(
                              icon: const Icon(Icons.restart_alt),
                              color: Colors.white,
                              onPressed: ()  {
                              setReset();
                              },
                            )
                        ),
                      ],
                    )
                        :
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                          icon: const Icon(Icons.play_arrow_rounded),
                          color: Colors.white,
                          onPressed: ()  {
                            startTimer();
                          },
                        )
                    ),
                  ]
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
                                widget.alarmHeader = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) {
                                    return AlarmEditScreen();
                                  },
                                ));
                                setState(() {});
                              })),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                          tooltip: 'Increase volume by 10',
                          onPressed: () {
                            setState(() {
                              //TODO silme yapılacak
                            });
                          },
                        ),
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
        style:  TextStyle(fontWeight: FontWeight.bold,color:Colors.red.shade300)
        )
      ],
    );
  }
}

class AlarmEditScreen extends StatelessWidget {
  AlarmEditScreen({Key? key}) : super(key: key);

  final TextEditingController _alarmNameController = TextEditingController();
  final TextEditingController _alarmTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade200,
        appBar: AppBar(
          title: const Text('Alarm Settings'),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _alarmNameController,
                  decoration: InputDecoration(
                      hintText: 'Alarm Name',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _alarmNameController.clear();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      border: const OutlineInputBorder(),
                      fillColor: Colors.lightBlue.shade100,
                      filled: true),
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value != null) {
                  //     if (int.parse(value) % 5 != 0) {
                  //       return "Please enter the multiples of 5";
                  //     }
                  //   }
                  // }
                )),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _alarmTimeController,
                  decoration: InputDecoration(
                      hintText: 'Frequency of use in hours: (Ex:12)',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _alarmTimeController.clear();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      border: const OutlineInputBorder(),
                      fillColor: Colors.lightBlue.shade100,
                      filled: true),
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value != null) {
                  //     if (int.parse(value) % 5 != 0) {
                  //       return "Please enter the multiples of 5";
                  //     }
                  //   }
                  // }
                )),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton.icon(
                    label: const Text('Save'),
                    icon: const Icon(Icons.save, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120.0, 45.0)),
                    onPressed: () {
                      final List<String> list = [
                        _alarmNameController.text,
                        _alarmTimeController.text
                      ];
                      Navigator.of(context).pop(list);
                    }))
          ],
        ));
  }
}
