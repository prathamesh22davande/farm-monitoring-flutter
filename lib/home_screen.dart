import 'package:farm_monitoring_flutter/api/get_data.dart';
import 'package:farm_monitoring_flutter/widgets/CustomLineGraph.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_monitoring_flutter/widgets/custom_badge.dart';


class HomeScreen extends StatefulWidget {
  List<int> arr;

  static String id = 'home_screen';

  // HomeScreen({this.dataLightIntensity,this.dataTemperature,this.dataMoisture});
  var dataLightIntensity;
  var dataTemperature;
  var dataMoisture;
  DataFormat data;


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int timeLightIntensity = 3;
  int timeTemperature =  3;
  int timeMoisture = 3;

  changeTimeLightIntensity(newTime){
    setState(() {
      timeLightIntensity = newTime;
    });
    print(timeLightIntensity);
  }
  changeTemperature(newTemperature){
    setState(() {
      timeTemperature = newTemperature;
    });
 //   print(timeTemperatureIntensity);
  }
  changeMoisture(newMoisture){
    setState(() {
      timeMoisture = newMoisture;
    });
    //   print(timeTemperatureIntensity);
  }


  List<charts.Series<LinearSales, int>> _createLightIntensityData() {
    int i =0;
     List<LinearSales> data = [];
    for (var x in widget.dataLightIntensity){
      if (i%timeLightIntensity==0)
        data.add(LinearSales(i,x));
      i++;
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Light Intensity',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  List<charts.Series<LinearSales, int>> _createTemperatureData() {
    int i =0;
    List<LinearSales> data = [];
    for (var x in widget.dataTemperature){
      if (i%timeTemperature==0)
        data.add(LinearSales(i,x));
      i++;
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  List<charts.Series<LinearSales, int>> _createMoistureData() {
    int i =0;
    List<LinearSales> data = [];
    for (var x in widget.dataMoisture){
      if (i%timeMoisture==0)
        data.add(LinearSales(i,x));
      i++;
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Moisture',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DataFormat data = await getData(context);
    // widget.dataLightIntensity = data.dataLightIntensity;
    // widget.dataTemperature = data.dataTemperature;
    // widget.dataMoisture = data.dataMoisture;
    print(widget.dataLightIntensity);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomLineGraph(
                    title: "Light intensity",
                    changeTime: changeTimeLightIntensity,
                    time: timeLightIntensity,
                    createSampleData: _createLightIntensityData,
                  ),
                  CustomLineGraph(
                    title: "Temperature",
                    changeTime: changeTemperature,
                    time: timeTemperature,
                    createSampleData: _createTemperatureData,
                  ),
                  CustomLineGraph(
                    title: "Moisture",
                    changeTime: changeMoisture,
                    time: timeMoisture,
                    createSampleData: _createMoistureData,
                  )
                ]
              ),
            ),
          ),
        ),

    );
  }
}



/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}



