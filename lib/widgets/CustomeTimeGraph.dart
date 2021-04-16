import 'package:flutter/material.dart';
import 'package:farm_monitoring_flutter/widgets/custom_badge.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class CustomTimeGraph extends StatefulWidget {

  final String title;
  final Function createSampleData;
  final Function changeTime;
  final int time;
  CustomTimeGraph({this.title,this.createSampleData,this.time,this.changeTime});


  @override
  _CustomTimeGraphState createState() => _CustomTimeGraphState();
}

class _CustomTimeGraphState extends State<CustomTimeGraph> {


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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
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
            child: charts.TimeSeriesChart(
              widget.createSampleData(),
              animate: true,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
              domainAxis: charts.DateTimeAxisSpec(
                tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                  day: charts.TimeFormatterSpec(
                    format: 'dd',
                    transitionFormat: 'dd MMM',
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBadge(
                time: 1,
                changeTime: widget.changeTime,
                decoration: widget.time==1?activeBadgeDecoration:inactiveBadgeDecoration,
                textStyle: widget.time==1?activeTextStyle:inactiveTextStyle,
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
      ),
    );
  }
}
