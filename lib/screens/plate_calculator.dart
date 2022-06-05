import 'package:flutter/material.dart';

class PlateCalculator extends StatefulWidget {
  const PlateCalculator({Key? key}) : super(key: key);

  @override
  State<PlateCalculator> createState() => _PlateCalculatorState();
}

class _PlateCalculatorState extends State<PlateCalculator> {
  int _barCount20 = 0;
  int _barCount10 = 0;
  int _barCount5 = 0;
  int _barCount2point5 = 0;
  final TextEditingController _totalWeightController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _totalWeightController.dispose();
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
  void calculateEachSide(int totalWeight) {
    print(totalWeight);
    double eachSide = (totalWeight - 20) / 2;
    print(eachSide);
    if (eachSide >= 20) {
      _barCount20 = eachSide ~/ 20;
      eachSide = eachSide % 20;
    }
    print(eachSide);
    if (eachSide >= 10) {
      print('girdi');
      print(eachSide);
      _barCount10 = eachSide ~/ 10;
      eachSide = eachSide % 10;
    }
    print(eachSide);
    if (eachSide >= 5) {
      _barCount5 = eachSide ~/ 5;
      eachSide = eachSide % 5;
    }
    print(eachSide);
    if (eachSide >= 2.5) {
      _barCount2point5 = eachSide ~/ 2.5;
      eachSide = (eachSide % 2.5);
    }
    print(eachSide);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        title: const Text('Plate Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.info),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Plate calculator bar weight is fixed to 20 kg\n'
                            '(Below results represents only one side of the bar.)'),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if ((_barCount20 > 0) ||
                        (_barCount10 > 0) ||
                        (_barCount5 > 0) ||
                        (_barCount2point5 > 0))
                      const Text(
                        'You need',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_barCount20 > 0)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.fitness_center,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '$_barCount20 x 20 kg plate',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_barCount10 > 0)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                  Icons.fitness_center,
                                  color: Colors.teal
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '$_barCount10 x 10 kg plate',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_barCount5 > 0)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.fitness_center,
                                color: Colors.teal,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '$_barCount5 x 5 kg plate',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_barCount2point5 > 0)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.fitness_center,
                                color: Colors.teal,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '$_barCount2point5 x 2.5 kg plate',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    TextFormField(
                        controller: _totalWeightController,
                        decoration: InputDecoration(
                            hintText: 'Enter total weight here (Ex:180)',
                            suffixIcon: IconButton(
                              onPressed: () {
                                _totalWeightController.clear();
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
                            if(isNumeric(value)){
                              if (int.parse(value) % 5 != 0) {
                                return "Please enter the multiples of 5";
                              }
                            }
                            else if (value.isEmpty){
                              return "Weight can not be empty!";
                            }
                            else{
                              return "Only numbers allowed!";
                            }

                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton.icon(
                              label: const Text('Calculate'),
                              icon: const Icon(Icons.add, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120.0, 45.0)
                              ),
                              onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                                  () {
                                final isProper = formKey.currentState?.validate();
                                if (isProper == true) {
                                  setState(() {
                                    _barCount20 = 0;
                                    _barCount10 = 0;
                                    _barCount5 = 0;
                                    _barCount2point5 = 0;
                                    calculateEachSide(
                                        int.parse(_totalWeightController.text));
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
                                  fixedSize: const Size(120.0, 45.0)
                              ),
                              onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                                  () {
                                setState(() {
                                  _barCount20 = 0;
                                  _barCount10 = 0;
                                  _barCount5 = 0;
                                  _barCount2point5 = 0;
                                  _totalWeightController.clear();
                                });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}