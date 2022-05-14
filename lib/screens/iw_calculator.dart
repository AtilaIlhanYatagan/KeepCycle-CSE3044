
import 'package:flutter/material.dart';

class IWCalculator extends StatefulWidget {
  const IWCalculator({Key? key}) : super(key: key);

  @override
  State<IWCalculator> createState() => _IWCalculatorState();
}

class _IWCalculatorState extends State<IWCalculator> {
  bool _male = false;
  bool _female = false;
  int _height = 0;
  double _idealWeight = 0;

  //Ideal body weight is computed in
  // men as 50 + (0.91 × [height in centimeters − 152.4])
  // and in women as 45.5 + (0.91 × [height in centimeters − 152.4]).
  double calculateIW(int height, bool male, bool female) {
    if (male == true) {
      return (50 + (0.91) * (height - 152.4));
    } else if (female == true) {
      return (50 + (0.91) * (height - 152.4));
    }
    return 0;
  }

  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Sample Code'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                        "Calculated Ideal Weight: " +
                            _idealWeight.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 22))),
              ),
              TextField(
                controller: _heightController,
                decoration: InputDecoration(
                    hintText: 'Enter your height here (Ex:180)',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _heightController.clear();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    border: const OutlineInputBorder(),
                    fillColor: Colors.lightBlue.shade100,
                    filled: true),
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
              CheckboxListTile(
                  title: const Text('male'),
                  secondary: const Icon(Icons.male),
                  controlAffinity: ListTileControlAffinity.leading,
                  tileColor: Colors.lightBlue.shade100,
                  value: _male,
                  onChanged: (value) {
                    setState(() {
                      _male = value!;
                      _female = false;
                    });
                  }),
              CheckboxListTile(
                  title: const Text('female'),
                  secondary: const Icon(Icons.female),
                  controlAffinity: ListTileControlAffinity.leading,
                  tileColor: Colors.lightBlue.shade100,
                  value: _female,
                  onChanged: (value) {
                    setState(() {
                      _female = value!;
                      _male = false;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton.icon(
                        label: const Text('Calculate'),
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                            () {
                          setState(() {
                            _height = int.parse(_heightController.text);
                            // _bodyWeight = int.parse(_weightController.text);
                            _idealWeight = calculateIW(_height, _male, _female);
                          });
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton.icon(
                        label: const Text('Reset'),
                        icon: const Icon(Icons.clear, color: Colors.red),
                        onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                            () {
                          setState(() {
                            _height = 0;
                            _heightController.clear();
                            _male = false;
                            _female = false;
                          });
                        }),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
