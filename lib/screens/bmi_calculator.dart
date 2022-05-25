

import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int _bodyWeight = 0;
  int _height = 0;
  double _BMI = 0;
  int _calculated = 0;

  double calculateBMI(int weight, int height) {
    return weight / (height * height / 10000);
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        appBar: AppBar(
          title: const Text('BMI Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Calculated BMI ' + _BMI.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 22),
                      )),
                ),

                // needs a fix (does not update the screen)
                // calculated == 1 print calculation results.
                 if (_calculated == 1) BmiInfo(bmi: _BMI, height: _height),

                TextFormField(
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
                  validator: (value){
                    if(value != null){
                      if(value.isEmpty){
                       return "Height can not empty!";
                      }
                    if(!isNumeric(value)){
                      return "Only numbers allowed!";
                    }
                    }
                  } ,
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(
                      hintText: 'Enter your weight here (Ex:80)',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _weightController.clear();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      border: OutlineInputBorder(),
                      fillColor: Colors.lightBlue.shade100,
                      filled: true),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  validator: (value){
                    if(value != null){
                      if(value.isEmpty){
                        return "Weight can not empty!";
                      }
                      if(!isNumeric(value)){
                        return "Only numbers allowed!";
                      }
                    }
                  } ,
                ),
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
                            final isProper = formKey.currentState?.validate();
                            if(isProper == true){
                              setState(() {
                                _height = int.parse(_heightController.text);
                                _bodyWeight = int.parse(_weightController.text);
                                _BMI = calculateBMI(_bodyWeight, _height);
                                _calculated = 1;
                              });
                            }

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
                              _bodyWeight = 0;
                              _BMI = 0;
                              _calculated = 0;
                              _weightController.clear();
                              _heightController.clear();
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class BmiInfo extends StatefulWidget {
  final double bmi;
  final int height;
  const BmiInfo({
    Key? key,
    required this.bmi,
    required this.height,
  }) : super(key: key);

  @override
  State<BmiInfo> createState() => _BmiInfoState();
}

class _BmiInfoState extends State<BmiInfo> {
  late final String info;
  late final double idealWeightUpperLimit;
  late final double idealWeightDownLimit;
  String setInfo() {
    if (widget.bmi < 18.5) {
      return 'You are underweight';
    } else if (widget.bmi > 18.5 && widget.bmi < 24.9) {
      return 'Your weight is ideal';
    } else if (widget.bmi > 25 && widget.bmi < 29.9) {
      return 'You are underweight';
    } else if (widget.bmi > 30) {
      return 'You are obese';
    }
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info = setInfo();
    idealWeightDownLimit = (widget.height) * (widget.height) * (18.5 / 10000);
    idealWeightUpperLimit = (widget.height) * (widget.height) * (24.9 / 10000);
  }

  @override
  void didUpdateWidget(covariant BmiInfo oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if((oldWidget.bmi != widget.bmi) || (oldWidget.height != widget.height)) {
      setState(() {
        info = setInfo();
        idealWeightDownLimit = (widget.height) * (widget.height) * (18.5 / 10000);
        idealWeightUpperLimit = (widget.height) * (widget.height) * (24.9 / 10000);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(info,style: const TextStyle(fontSize: 15.0),)
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text('Your ideal weight is between ' +
                  idealWeightDownLimit.toStringAsFixed(1) + ' and ' +
                  idealWeightUpperLimit.toStringAsFixed(1) +'.',
                style: const TextStyle(fontSize: 15.0),
              )
          ),
        ],
      ),
    );
  }
}