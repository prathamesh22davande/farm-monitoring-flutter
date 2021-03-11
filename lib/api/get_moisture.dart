import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Moisture{
  int data;
  DateTime time;
  Moisture({this.data,this.time});
}

Future<List<Moisture>> getMoistureData () async{
  print("method called");
  try{
    http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/fields/3.json?api_key=GG8YZU6QEOKRPEHM&results');
    //http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/feeds.json?api_key=GG8YZU6QEOKRPEHM&results');
    List<Moisture> arr = [];
    if (response.statusCode == 200) {
      var data = response.body;
      //print(jsonDecode(data));
      var createdAt = jsonDecode(data)['feeds'];
      //print('Length : '+createdAt.length);
      //print(createdAt);
      //print('*********************\n');
      for (var x in createdAt) {
        print(x);
        if (x['field3'] != null) {

          arr.add(Moisture(data: double.parse(x['field3']).toInt(),
              time: DateTime.parse(x['created_at'])));
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