import 'package:farm_monitoring_flutter/home_screen.dart';
import 'package:farm_monitoring_flutter/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<DataFormat> getData (BuildContext context) async{
  print('method Called');
  //http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/fields/2.json?api_key=GG8YZU6QEOKRPEHM&results');
  http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/feeds.json?api_key=GG8YZU6QEOKRPEHM&results');
  if (response.statusCode == 200){
    var data = response.body;
    print(data);
    var createdAt = jsonDecode(data)['feeds'];
    print("******************");
    print(createdAt);
    print("******************");
    List<int> arrLightIntensity = [];
    List<int> arrTemperature = [];
    List<int> arrMoisture = [];
    for (var x in createdAt){
      //print('DATA : ${x['field2']}');
      if(x['field1']!=null){
        arrTemperature.add(double.parse(x['field1']).toInt());
      }
      if (x['field2']!=null) {
        arrLightIntensity.add(int.parse(x['field2']));
      }
      if (x['field3']!=null) {
        arrMoisture.add(double.parse(x['field3']).toInt());
      }
    }
    // for (var x in arr){
    //   print('data : $x');
    // }
    // Navigator.push(context,MaterialPageRoute(builder: (context){
    //   // return HomeScreen(
    //   //     dataLightIntensity: arrLightIntensity,
    //   //     dataTemperature: arrTemperature,
    //   //     dataMoisture: arrMoisture,
    //   // );
    //
    //   // return BottomNavigationScreen(
    //   //   dataLightIntensity: arrLightIntensity,
    //   //   dataTemperature: arrTemperature,
    //   //   dataMoisture: arrMoisture,
    //   // );
    //
    //   return
    // }));
    return DataFormat(
      dataLightIntensity: arrLightIntensity,
      dataTemperature: arrTemperature,
      dataMoisture: arrMoisture,
    );

  }else{
    print('ERROR ${response.statusCode}');
    return null;
  }
}

class DataFormat{
  var dataLightIntensity;
  var dataTemperature;
  var dataMoisture;
  DataFormat({this.dataLightIntensity,this.dataTemperature,this.dataMoisture});
}