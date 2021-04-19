import 'dart:convert';
import 'package:farm_monitoring_flutter/api/get_tasks.dart';
import 'package:farm_monitoring_flutter/models/Task.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_search/dropdown_search.dart';
class Calender extends StatefulWidget {
  static String id = "calender";
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  Map<DateTime, List<dynamic>>  _activity;
  List<dynamic> _selectedEvents;
  DateTime selectedDate;
  TextEditingController _eventController;
  SharedPreferences prefs;
  bool flag = false;
  String activityValue="Irrigation";
  bool showSpinner = false;
  List<Task> tasks=[];

  // var now = new DateTime.now();
  // var formatter = new DateFormat('yyyy-MM-dd');
  // String formattedDate;
  // to get time

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _activity={};
    _selectedEvents = [];
    //prefsData();
  }
  // prefsData() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _events = Map<DateTime, List<dynamic>>.from(
  //         decodeMap(json.decode(prefs.getString("events") ?? "{}")));
  //   });
  // }


  // Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  //   Map<String, dynamic> newMap = {};
  //   map.forEach((key, value) {
  //     newMap[key.toString()] = map[key];
  //   });
  //   print(newMap);
  //   return newMap;
  // }
  //
  // Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  //   Map<DateTime, dynamic> newMap = {};
  //   map.forEach((key, value) {
  //     newMap[DateTime.parse(key)] = map[key];
  //   });
  //   print(newMap);
  //   return newMap;
  // }
  TextStyle dayStyle(FontWeight fontWeight, Color color) {
    return TextStyle(color: color, fontWeight: fontWeight);
  }
  // Container taskList(
  //     String task, String description, IconData img, Color color) {
  //   return Container(
  //     padding: EdgeInsets.only(top: 20),
  //     child: Row(
  //       children: [
  //         Icon(
  //           img,
  //           color: color,
  //           size: 20,
  //         ),
  //         Container(
  //           padding: EdgeInsets.only(left: 10, right: 10),
  //           width: MediaQuery.of(context).size.width * 0.8,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 task,
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 18),
  //               ),
  //               SizedBox(
  //                 height: 5.0,
  //               ),
  //               Text(
  //                 description,
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.normal,
  //                     fontSize: 15.0,
  //                     color: Colors.white),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              TableCalendar(
                events: _events,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarController: _controller,
                calendarStyle: CalendarStyle(
                  weekdayStyle: dayStyle(FontWeight.normal, Colors.black),
                  weekendStyle: dayStyle(FontWeight.normal, Colors.red),
                ),
                initialCalendarFormat: CalendarFormat.week,
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Color(0xff0F1233),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                    weekendStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0)),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                      color: Color(0xff0F1233),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Color(0xff0F1233),
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Color(0xff0F1233),
                  ),
                ),
                availableGestures: AvailableGestures.none,
                onDaySelected: (date, events, holidays) {
                  setState(() {
                    _selectedEvents = events;
                    loadTasks();
                  });
                  flag=true;
                  selectedDate=date;
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(child: Container(color:Colors.black),),
              Container(
                child:flag?_buildListView(tasks):Text('task'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color(0xff0F1233),
        ),
        onPressed: () async {

          _showAddDialog(context);
        },
      ),
    );
  }
  _showAddDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Add Events"),
          content: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Activity Type',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.0,),
                  DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: ['Irrigation', 'Nutrients', 'Spray pest and Disease', 'Farm Practice','Other'],
                    label: "Activites",
                    selectedItem: 'Irrigation',
                    onChanged: (value) {
                      activityValue=value;
                    },
                  ),
                  SizedBox(height: 20.0,),
                  Text('Resources Used',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20.0,),
                  TextField(
                    decoration:InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.blueAccent,
                    ),
                    controller: _eventController,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ],
                verticalDirection: VerticalDirection.down,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onPressed:  () {
                setState(() {
                  showSpinner=true;
                });
                if (_eventController.text.isEmpty) return;

                String activity = activityValue;
                String description = _eventController.text;
                DateTime date = _controller.selectedDay;

                addTask(activity, description, date);
                print(_events);
                // setState(() {
                //   if (_events[_controller.selectedDay] != null) {
                //     _events[_controller.selectedDay]
                //         .add(_eventController.text);
                //     _activity[_controller.selectedDay].add(activityValue);
                //   } else {
                //     _events[_controller.selectedDay] = [
                //       _eventController.text
                //     ];
                //     _activity[_controller.selectedDay]=[activityValue];
                //   }
                //   // formattedDate = formatter.format(now); to get date
                //   prefs.setString(
                //       "events", json.encode(encodeMap(_events)));
                //   _eventController.clear();
                //   Navigator.pop(context);
                // });
                Navigator.pop(context);
              },
            )
          ],
        ));
  }

  _buildListView(List<Task> tasks) {
    List<Task> taskPrint=[];
    for(var task in tasks)
      {
        if(selectedDate==task.date)
          {
            taskPrint.add(task);
          }
      }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: taskPrint.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff00A961),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  title: Text('Task', style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
                  subtitle: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          taskPrint[index].taskName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        Text('Description:'),
                        Text(taskPrint[index].taskDescription.toString(),
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.0),),
                        Text(taskPrint[index].date.toString(), style: TextStyle(
                            color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0,)
            ],
          );
        },
      ),
    );
  }

  loadTasks() async{
    List<Task> arr = await getTasks();
    setState(() {
      tasks = arr;
    });
    print(tasks);
  }

  Future<bool> addTask(String activity,String description,DateTime date) async{
    String url = 'https://infinite-fjord-59639.herokuapp.com/tasks';
    Map<String, String> headers = {"Content-type": "application/json"};



    Response response = await post(url, headers: headers,
        body: jsonEncode(
            <String, String>{
              'taskName': activity,
              'taskDescription':description,
              'date':date.toString()
            }));
    int statusCode = response.statusCode;
    await loadTasks();
    setState(() {
      showSpinner=false;
    });
    if (statusCode == 200){
      print("***************DATA INSERTED SUCCESSFULLY");
      return true;
    }else{
      print(statusCode);
      print("EROR");
      return false;
    }

  }

}




