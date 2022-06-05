import 'package:flutter/material.dart';

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
