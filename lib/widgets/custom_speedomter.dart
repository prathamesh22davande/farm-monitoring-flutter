import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomSpeedometer extends StatelessWidget {

  final double minValue;
  final double maxValue;
  final double pointerValue;
  final List<CustomRange> ranges;
  final String title;
  CustomSpeedometer({this.minValue,this.maxValue,this.pointerValue,this.ranges,this.title});

  @override
  Widget build(BuildContext context) {
    var customRange = getRanges();
    return Container(

      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
        //  color: Colors.white, //background color of box
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            child: SfRadialGauge(
                //enableLoadingAnimation: true,
                axes: <RadialAxis>[
                  RadialAxis(minimum: minValue, maximum: maxValue,
                      ranges: customRange,
                      pointers: <GaugePointer>[
                        NeedlePointer(value: pointerValue,needleEndWidth: 5)],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(widget: Container(child:
                        Text(pointerValue.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                            angle: 90, positionFactor: 1
                        )]
                  )]),
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<GaugeRange> getRanges(){
    List<GaugeRange> ans=[];
    for (var range in ranges){
      ans.add(GaugeRange(startValue: range.startValue, endValue: range.endValue,color: range.color));
    }
    return ans;
  }
}

class CustomRange{
  double startValue;
  double endValue;
  Color color;
  CustomRange(this.startValue,this.endValue,this.color);
}
