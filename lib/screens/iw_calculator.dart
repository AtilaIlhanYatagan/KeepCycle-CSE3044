
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
      return (45.5 + (0.91) * (height - 152.4));
    }
    return 0;
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  final TextEditingController _heightController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        appBar: AppBar(
          title: const Text('Ideal Weight Calculator'),
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
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                          "Calculated Ideal Weight: " +
                              _idealWeight.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 22))),
                ),
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
                               final isProper = formKey.currentState?.validate();
                               if(isProper == true) {
                                 setState(() {
                                   _height = int.parse(_heightController.text);
                                   // _bodyWeight = int.parse(_weightController.text);
                                   if(_female == null && _male == null ){
                                      print("Please select Male or Female");
                                   }
                                   _idealWeight =
                                       calculateIW(_height, _male, _female);
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
          ),
        ));
  }
}
