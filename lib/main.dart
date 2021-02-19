import 'package:farm_monitoring_flutter/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

Future<bool> getData (BuildContext context) async{
  print('method Called');
  //http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/fields/2.json?api_key=GG8YZU6QEOKRPEHM&results');
  http.Response response = await http.get('https://api.thingspeak.com/channels/1288997/feeds.json?api_key=GG8YZU6QEOKRPEHM&results');
  if (response.statusCode == 200){
    var data = response.body;
    print(data);
    var createdAt = jsonDecode(data)['feeds'];
    print("******************");
    print(createdAt);
    print("******************");
    List<int> arrLightIntensity = [];
    List<int> arrTemperature = [];
    List<int> arrMoisture = [];
    for (var x in createdAt){
      //print('DATA : ${x['field2']}');
      arrTemperature.add(double.parse(x['field1']).toInt());
      arrLightIntensity.add(int.parse(x['field2']));
      arrMoisture.add(double.parse(x['field3']).toInt());
    }
    // for (var x in arr){
    //   print('data : $x');
    // }
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return HomeScreen(
          dataLightIntensity: arrLightIntensity,
          dataTemperature: arrTemperature,
          dataMoisture: arrMoisture,
      );
    }));
    return true;

  }else{
    print('ERROR ${response.statusCode}');
  }
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          HomeScreen.id: (context) => HomeScreen(),
        },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getData(context);
    return Scaffold(
      body: Center(
        // child: SpinKitDoubleBounce(
        //   color: Colors.black54,
        // ),
        child: Lottie.network('https://assets3.lottiefiles.com/private_files/lf30_7yNCzX.json'),
      ),
    );
  }
}


class CustomCard extends StatelessWidget {

  final String name;
  final String image;
  final String subtitle;
  CustomCard({this.name,this.image,this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            name,
          ),
          Image.asset(
              'images/$image',
              height: 80,
              width: 80,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
