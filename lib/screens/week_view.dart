import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class WeekViewDisplay extends StatelessWidget {
  static String id="week_view";
  WeekViewDisplay({this.event,this.activity});
  final Map<DateTime,List<dynamic>> event;
  final Map<DateTime,List<dynamic>> activity;
  List<String> months=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Nov","Dec"];
  List<dynamic> events=[];
  List<DateTime> dates=[];
  List<dynamic> activities=[];

  @override
  Widget build(BuildContext context) {
    dates=event.keys.toList();
    events=event.values.toList();
    activities=activity.values.toList();
    return Container(
      height: MediaQuery.of(context).size.height-215,
      color: Colors.blueAccent,
      child: _buildListView(dates,events,activities),
      // child: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 25.0),
      //     child: WeekView(
      //       dates: [date.subtract(Duration(days: 1)), date, date.add(Duration(days: 1))],
      //       events: [
      //         FlutterWeekViewEvent(
      //           title: 'An event 1',
      //           description: event.toString(),
      //           start: date.subtract(Duration(hours: 1)),
      //           end: date.add(Duration(hours: 18, minutes: 30)),
      //         ),
      //       ],
      //     ),
      //   ),

    );
  }
  ListView _buildListView(List<DateTime> date,List<dynamic> event,List<dynamic> activities) {
    int j=0;
    DateTime now = DateTime.now();
    // DateTime findLastDateOfTheWeek(DateTime dateTime) {
    //   return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
    // }
    // DateTime dates = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
    // print(dates);
    return ListView.builder(
        itemCount:event.length,
        itemBuilder: (context, index) {
          // title:Text(date[index].day.toString() + "-" + months[date[index].month-1])
          return ListTile(
            selectedTileColor: Colors.white,
            title: Text(activities[index][j].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Resources Used: '+event[index][j].toString()),
                Text('Date: '+date[index].day.toString()+ "-" + months[date[index].month-1]+"-"+date[index].year.toString()),
              ],
            ),

          );
        }
    );
  }
}