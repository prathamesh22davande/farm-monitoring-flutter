import 'package:cool_alert/cool_alert.dart';
import 'package:farm_monitoring_flutter/screens/login.dart';
import 'package:farm_monitoring_flutter/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  static String id = 'sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xff000000),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black54.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage(
              'images/login_background.jpg',
            ),
            fit: BoxFit.cover,
          ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Farm\nMonitor',
                style: TextStyle(
                  color: Color(0xffD7EBE1),
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 20,),
              CustomTextField(
                changeValue:(newValue){
                email = newValue;
              },label: 'Username',isPassword: false,textColor: 0xffD7EBE1,lablelColor: 0xffD7EBE1,),
              SizedBox(height: 20,),
              CustomTextField(changeValue:(newValue){
                password = newValue;
              },label: 'Password',isPassword: true,textColor: 0xffD7EBE1,lablelColor: 0xffD7EBE1,),
              SizedBox(height: 20,),
              CustomTextField(label: 'Confirm Password',isPassword: true,textColor: 0xffD7EBE1,lablelColor: 0xffD7EBE1,),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  onPressed: () async {
                    //TODO: Implement registration functionality.
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if (newUser!=null){
                        //Navigator.pushNamed(context, Login.id);
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text: "Your transaction was successful!",
                        );
                      }

                    }catch(e){
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });

                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Text(
                        'Register',
                        style: TextStyle(color: Color(0xffD7EBE1)),
                    ),
                  color: Color(0xff1B5E4C),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Registered ?  ',
                    style: TextStyle(color: Color(0xff5caa8b)),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Login.id);
                    },
                    child: Text(
                      'Sign in here ',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
      ),
    ),
        ));
  }
}
