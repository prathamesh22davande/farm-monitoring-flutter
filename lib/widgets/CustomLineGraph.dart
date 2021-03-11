import 'package:flutter/material.dart';
import 'package:farm_monitoring_flutter/widgets/custom_badge.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class CustomLineGraph extends StatefulWidget {

  final String title;
  final Function createSampleData;
  final Function changeTime;
  final int time;
  CustomLineGraph({this.title,this.createSampleData,this.time,this.changeTime});


  @override
  _CustomLineGraphState createState() => _CustomLineGraphState();
}

class _CustomLineGraphState extends State<CustomLineGraph> {


  //Decoration for badge
  BoxDecoration activeBadgeDecoration = BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20)
  );
  BoxDecoration inactiveBadgeDecoration = BoxDecoration(
      color: Colors.green[50],
      borderRadius: BorderRadius.circular(20)
  );
  //Style for badge text
  TextStyle activeTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold
  );
  TextStyle inactiveTextStyle = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          height: 300,
          width: double.infinity,
          child: charts.LineChart(
            widget.createSampleData(),
            animate: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBadge(
              time: 3,
              changeTime: widget.changeTime,
              decoration: widget.time==3?activeBadgeDecoration:inactiveBadgeDecoration,
              textStyle: widget.time==3?activeTextStyle:inactiveTextStyle,
            ),
            CustomBadge(
              time: 5,
              changeTime: widget.changeTime,
              decoration: widget.time==5?activeBadgeDecoration:inactiveBadgeDecoration,
              textStyle: widget.time==5?activeTextStyle:inactiveTextStyle,
            ),
            CustomBadge(
              time: 9,
              changeTime: widget.changeTime,
              decoration: widget.time==9?activeBadgeDecoration:inactiveBadgeDecoration,
              textStyle: widget.time==9?activeTextStyle:inactiveTextStyle,
            ),
            CustomBadge(
              time: 12,
              changeTime: widget.changeTime,
              decoration: widget.time==12?activeBadgeDecoration:inactiveBadgeDecoration,
              textStyle: widget.time==12?activeTextStyle:inactiveTextStyle,
            ),
          ],
        )
      ],
    );
  }
}
