import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlotScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Text('Plot Screen'),
          FlatButton(
              onPressed: (){
                _auth.signOut();
              },
              child: Text('Sign Out')
          ),
        ],
      ),
    );
  }
}
