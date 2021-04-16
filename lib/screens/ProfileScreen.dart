import 'package:farm_monitoring_flutter/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/farmer_profile.png'),
                  radius: 50,
                ),
                SizedBox(height: 20,),
                Text(
                  _auth.currentUser.email,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  color: Colors.green,
                    onPressed: (){
                      _auth.signOut();
                        Navigator.popAndPushNamed(context, Login.id);
                    },
                    child:Text('Logout'),
                )
              ],
          ),
        ),
      ),
    );
  }
}
