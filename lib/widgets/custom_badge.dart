import 'package:flutter/material.dart';
class CustomBadge extends StatelessWidget {

  final Function changeTime;
  final BoxDecoration decoration;
  final TextStyle textStyle;
  final int time;
  CustomBadge({this.time,this.changeTime,this.decoration,this.textStyle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('Badge Clicked');
        changeTime(time);
      },
      child: Container(
        height: 40,
        width: 70,
        decoration: decoration,
        child: Center(
          child: Text(
            '$time HR',
            style: textStyle,
          ),
        ),
      ),
    );
  }
}

