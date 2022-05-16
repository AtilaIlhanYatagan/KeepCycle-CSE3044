
import 'package:deneme/Screens/plate_calculator.dart';
import 'package:flutter/material.dart';

import 'bmi_calculator.dart';
import 'calorie_calculator.dart';
import 'iw_calculator.dart';


class calculator_selection_page extends StatelessWidget {
  const calculator_selection_page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CalorieCalculator();
                      },
                    ));
                  },
                  child: const Text('CalCalculator'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130.0, 90.0)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return PlateCalculator();
                      },
                    ));
                  },
                  child: const Text('PlateCalculator'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130.0, 90.0)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return BMICalculator();
                      },
                    ));
                  },
                  child: const Text('BMICalculator'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130.0, 90.0)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return IWCalculator();
                      },
                    ));
                  },
                  child: const Text('IWCalculator'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130.0, 90.0)),
                ),
              ],
            ),
          ],
        ));
  }
}