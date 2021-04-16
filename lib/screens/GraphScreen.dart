import 'package:farm_monitoring_flutter/api/get_light_intensity.dart';
import 'package:farm_monitoring_flutter/api/get_temperature.dart';
import 'package:farm_monitoring_flutter/home_screen.dart';
import 'package:farm_monitoring_flutter/widgets/CustomLineGraph.dart';
import 'package:farm_monitoring_flutter/api/get_moisture.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_monitoring_flutter/widgets/CustomeTimeGraph.dart';

import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  var timeMoisture = 1;
  var timeTemperature = 1;
  var timeLightIntensity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            //future: getMoistureData(),
            future: getAllData(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              //print(snapshot.data);
              if(snapshot.data==null){
                return Container(
                  child: Center(child: Text('Loading.....')),
                );
              }else{

                List<charts.Series<Moisture, DateTime>> _createMoistureData() {
                  int i =0;
                  List<Moisture> data = [];
                  for (var x in snapshot.data.moistureArr){
                    if (i%timeMoisture==0)
                      data.add(Moisture(time:x.time,data:x.data));
                    i++;
                  }

                  return [
                    new charts.Series<Moisture, DateTime>(
                      id: 'Moisture',
                      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                      domainFn: (Moisture sales, _) => sales.time,
                      measureFn: (Moisture sales, _) => sales.data,
                      data: data,
                    )
                  ];
                }
                changeMoisture(newMoisture){
                  setState(() {
                    timeMoisture = newMoisture;
                  });
                   // print(timeTemperatureIntensity);
                }
                // return ListView.builder(
                //     itemCount: snapshot.data.length,
                //     itemBuilder: (BuildContext context,int index){
                //       return ListTile(
                //         title: Text(snapshot.data[index].data.toString()),
                //       );
                //     }
                // );


                List<charts.Series<Temperature, DateTime>> _createTemperatureData() {
                  int i =0;
                  List<Temperature> data = [];
                  for (var x in snapshot.data.temperatureArr){
                    if (i%timeTemperature==0)
                      data.add(Temperature(time:x.time,data:x.data));
                    i++;
                  }

                  return [
                    new charts.Series<Temperature , DateTime>(
                      id: 'Temperature',
                      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                      domainFn: (Temperature sales, _) => sales.time,
                      measureFn: (Temperature sales, _) => sales.data,
                      data: data,
                    )
                  ];
                }
                changeTemperature(newTemperature){
                  setState(() {
                    timeTemperature = newTemperature;
                  });
                  //   print(timeTemperatureIntensity);
                }

                List<charts.Series<LightIntensity, DateTime>> _createLightIntensityData() {
                  int i =0;
                  List<LightIntensity> data = [];
                  for (var x in snapshot.data.lightIntensityArr){
                     if (i%timeLightIntensity==0)
                    //data.add(LightIntensity(time:x.time,x.data));
                    data.add(LightIntensity(time: x.time,data: x.data));
                    i++;
                  }

                  return [
                    new charts.Series<LightIntensity, DateTime>(
                      id: 'LightIntensity',
                      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                      domainFn: (LightIntensity sales, _) => sales.time,
                      measureFn: (LightIntensity sales, _) => sales.data,
                      data: data,
                    )
                  ];
                }
                changeLightIntensity(newLightIntensity){
                  setState(() {
                    timeLightIntensity = newLightIntensity;
                  });
                  //   print(timeTemperatureIntensity);
                }



                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      CustomTimeGraph(
                      title: "Moisture",
                      changeTime: changeMoisture,
                      time: timeMoisture,
                      createSampleData: _createMoistureData,
                    ),
                      SizedBox(height: 40,),
                      CustomTimeGraph(
                        title: "Temperature",
                        changeTime: changeTemperature,
                        time: timeTemperature,
                        createSampleData: _createTemperatureData,
                      ),
                      SizedBox(height: 40,),
                      CustomTimeGraph(
                        title: "Light Intensity",
                        changeTime: changeLightIntensity,
                        time: timeLightIntensity,
                        createSampleData: _createLightIntensityData,
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AllData{
  List<Moisture> moistureArr;
  List<Temperature> temperatureArr;
  List<LightIntensity> lightIntensityArr;
  AllData({this.moistureArr,this.temperatureArr,this.lightIntensityArr});
}

Future<AllData> getAllData() async{
  List<Moisture> moistureArr = await getMoistureData();
  List<Temperature> temperatureArr = await getTemperatureData();
  List<LightIntensity> lightIntensityArr = await getLightIntensityData();
  return AllData(moistureArr: moistureArr,temperatureArr: temperatureArr,lightIntensityArr: lightIntensityArr);
}