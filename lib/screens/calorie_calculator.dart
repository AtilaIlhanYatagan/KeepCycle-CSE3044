import 'package:flutter/material.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({Key? key}) : super(key: key);

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  final _exerciseSelection = [
    'little or no exercise',
    'light exercise (1-3 days/week)',
    'moderate exercise (3-5 days/week)',
    'hard exercise (6-7 days/week)',
    'very hard exercise and a physical job'
  ];

  String? _selectedExercise;
  double _bmr = 0;
  double _caloriePerDay = 0;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _fatPercentageController =
      TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _fatPercentageController.dispose();
    super.dispose();
  }

  void setBMR(int bodyWeight, int fatPercentage, String exerciseLevel) {
    //LBM = (Weight[kg] * (100 - Body Fat %)/100
    //BMR = 370 + (21.6 * Lean Body Mass[kg])

    double LBM = bodyWeight * (100 - fatPercentage) / 100;
    _bmr = 370 + (21.6 * LBM);

    if (exerciseLevel == 'little or no exercise') {
      _caloriePerDay = _bmr * 1.2;
    } else if (exerciseLevel == 'light exercise (1-3 days/week)') {
      _caloriePerDay = _bmr * 1.375;
    } else if (exerciseLevel == 'moderate exercise (3-5 days/week)') {
      _caloriePerDay = _bmr * 1.55;
    } else if (exerciseLevel == 'hard exercise (6-7 days/week)') {
      _caloriePerDay = _bmr * 1.725;
    } else if (exerciseLevel == 'very hard exercise and a physical job') {
      _caloriePerDay = _bmr * 1.9;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.red.shade300,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Calorie Calculator'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(context: context, builder: (context) => const InformationDialog());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (_bmr > 0)
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'BMR:' + _bmr.toStringAsFixed(0) + ' kcal/day',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  if (_caloriePerDay > 0)
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Calorie need:' +
                                  _caloriePerDay.toStringAsFixed(0) +
                                  ' kcal/day',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: TextFormField(
                        controller: _weightController,
                        decoration: InputDecoration(
                            hintText: 'Your body weight (Ex:75)',
                            suffixIcon: IconButton(
                              onPressed: () {
                                _weightController.clear();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            border: const OutlineInputBorder(),
                            fillColor: Colors.lightBlue.shade100,
                            filled: true),
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        validator: (value) {
                          if (value != null) {
                            //int.parse(value) % 5 != 0 ifin içi
                            if (false) {
                              return "Please enter the multiples of 5";
                            }
                          }
                          return null;
                        }),
                  ),
                  TextFormField(
                      controller: _fatPercentageController,
                      decoration: InputDecoration(
                          hintText: 'Your body fat percentage (Ex:12)',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _fatPercentageController.clear();
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          border: const OutlineInputBorder(),
                          fillColor: Colors.lightBlue.shade100,
                          filled: true),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      validator: (value) {
                        if (value != null) {
                          //int.parse(value) % 5 != 0 ifin içi
                          if (false) {
                            return "Please enter the multiples of 5";
                          }
                        }
                        return null;
                      }),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Exercise Level",
                        fillColor: Colors.lightBlue.shade100,
                      ),
                      dropdownColor: Colors.teal,
                      value: _selectedExercise,
                      items: _exerciseSelection
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _selectedExercise = value.toString();
                          }
                          //print(selectedExercise);
                        });
                      }),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton.icon(
                              label: const Text('Calculate'),
                              icon: const Icon(Icons.add, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120.0, 45.0)),
                              onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                                  () {
                                final isproper =
                                    formKey.currentState?.validate();
                                if (isproper == true) {
                                  setState(() {
                                    setBMR(
                                        int.parse(_weightController.text),
                                        int.parse(
                                            _fatPercentageController.text),
                                        _selectedExercise!);
                                  });
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton.icon(
                              label: const Text('Reset'),
                              icon: const Icon(Icons.clear, color: Colors.red),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120.0, 45.0)),
                              onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                                  () {
                                setState(() {
                                  _fatPercentageController.clear();
                                  _weightController.clear();
                                  _selectedExercise = null;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
class InformationDialog extends StatelessWidget {
  const InformationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('BMR Information'),
      content: const Text('This calculator uses Katch-McArdle formula and allows you to calculate your Basal Metabolic Rate, (BMR), which is the minimum amount of calories your body needs per day to keep functioning, assuming you were to do no exercise for that day.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}