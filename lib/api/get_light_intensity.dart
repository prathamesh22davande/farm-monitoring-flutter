import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LightIntensity{
  int data;
  DateTime time;
  LightIntensity({this.data,this.time});
}

Future<List<LightIntensity>> getLightIntensityData () async{
  print("method called");
  try{
    //http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/fields/3.json?api_key=GG8YZU6QEOKRPEHM&results');
    http.Response response = await http.get('https://infinite-fjord-59639.herokuapp.com/farmData');
    List<LightIntensity> arr = [];
    if (response.statusCode == 200) {
      var data = response.body;
      //print(jsonDecode(data));
      var createdAt = jsonDecode(data);
      //print('Length : '+createdAt.length);
      //print(createdAt);
      //print('*********************\n');
      for (var x in createdAt) {
        print(x);
        if (x['lightIntensity'] != null) {

          arr.add(LightIntensity(data: double.parse(x['lightIntensity']).toInt(),
              time: DateTime.parse(x['time'])));
        }
      }
      return arr;
    }
  }
  catch(e){
    print('Error : '+e);
    return null;
  }


}