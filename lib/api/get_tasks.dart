import 'dart:convert';

import 'package:farm_monitoring_flutter/models/Task.dart';
import 'package:http/http.dart' as http;


Future<List<Task>> getTasks() async{
  List<Task> arr = [];
  http.Response response = await http.get('https://infinite-fjord-59639.herokuapp.com/tasks');
  if (response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data);
    for (var x in data){
      String taskName = x['taskName'].toString();
      String taskDescription = x['taskDescription'].toString();
      DateTime date = DateTime.parse(x['date'].toString());
      Task task = new Task(taskName: taskName,taskDescription: taskDescription,date: date);
      arr.add(task);
    }
  }
  return arr;
}