import 'package:farm_monitoring_flutter/home_screen.dart';
import 'package:farm_monitoring_flutter/widgets/CustomLineGraph.dart';
import 'package:farm_monitoring_flutter/api/get_moisture.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: FutureBuilder(
          future: getMoistureData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            //print(snapshot.data);
            if(snapshot.data==null){
              return Container(
                child: Center(child: Text('Loading.....')),
              );
            }else{


              List<charts.Series<LinearSales, int>> _createMoistureData() {
                int i =0;
                List<LinearSales> data = [];
                for (var x in snapshot.data){
                  if (i%3==0)
                    data.add(LinearSales(i,x.data));
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
              changeMoisture(newMoisture){
                // setState(() {
                //   timeMoisture = newMoisture;
                // });
                //   print(timeTemperatureIntensity);
              }


              // return ListView.builder(
              //     itemCount: snapshot.data.length,
              //     itemBuilder: (BuildContext context,int index){
              //       return ListTile(
              //         title: Text(snapshot.data[index].data.toString()),
              //       );
              //     }
              // );

              return CustomLineGraph(
                title: "Moisture",
                changeTime: changeMoisture,
                time: 3,
                createSampleData: _createMoistureData,
              );
            }
          },
        ),
      ),
    );
  }
}
