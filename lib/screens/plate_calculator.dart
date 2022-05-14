
import 'package:flutter/material.dart';

class PlateCalculator extends StatefulWidget {
  const PlateCalculator({Key? key}) : super(key: key);

  @override
  State<PlateCalculator> createState() => _PlateCalculatorState();
}

class _PlateCalculatorState extends State<PlateCalculator> {
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
