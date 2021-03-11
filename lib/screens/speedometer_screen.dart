import 'package:farm_monitoring_flutter/widgets/custom_speedomter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class SpeedometerScreen extends StatelessWidget {

  static String id = 'speedometer_screen';

  var soilMoistureRange = [
    CustomRange(0,30,Colors.green),
    CustomRange(31,50,Colors.yellow),
    CustomRange(51,100,Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Expanded(
          child: CustomSpeedometer(
            minValue: 0,
            maxValue: 150,
            pointerValue: 25,
            ranges: soilMoistureRange,
            title: 'Soil Moisture',
          ),
        ),
      ),
    );
  }
}
