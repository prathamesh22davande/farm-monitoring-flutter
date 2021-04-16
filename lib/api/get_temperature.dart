import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Temperature{
  int data;
  DateTime time;
  Temperature({this.data,this.time});
}

Future<List<Temperature>> getTemperatureData () async{
  print("method called");
  try{
    //http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/fields/3.json?api_key=GG8YZU6QEOKRPEHM&results');
    http.Response response = await http.get('https://infinite-fjord-59639.herokuapp.com/farmData');
    List<Temperature> arr = [];
    if (response.statusCode == 200) {
      var data = response.body;
      //print(jsonDecode(data));
      var createdAt = jsonDecode(data);
      //print('Length : '+createdAt.length);
      //print(createdAt);
      //print('*********************\n');
      for (var x in createdAt) {
        print(x);
        if (x['temperature'] != null) {

          arr.add(Temperature(data: double.parse(x['temperature']).toInt(),
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