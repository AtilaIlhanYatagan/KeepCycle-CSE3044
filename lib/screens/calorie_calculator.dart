
import 'package:flutter/material.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({Key? key}) : super(key: key);

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: const Center(child: Text('You have pressed the button  times.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
