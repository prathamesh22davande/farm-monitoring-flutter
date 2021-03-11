import 'package:cool_alert/cool_alert.dart';
import 'package:farm_monitoring_flutter/api/get_data.dart';
import 'package:farm_monitoring_flutter/home_screen.dart';
import 'package:farm_monitoring_flutter/screens/bottom_nav_screen.dart';
import 'package:farm_monitoring_flutter/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:farm_monitoring_flutter/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF9F7FA),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(

            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffF9F7FA),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black54.withOpacity(0.7), BlendMode.dstATop),
                image: AssetImage(
                  'images/login_background1.jpg',
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
                      color: Color(0xff1B5E4C),
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    changeValue:(newValue){
                      email = newValue;
                    },
                    label: 'Username',isPassword: false,textColor: 0xff1B5E4C,lablelColor: 0xff1B5E4C,),
                  SizedBox(height: 20,),
                  CustomTextField(
                    changeValue:(newValue){
                      password = newValue;
                    },
                    label: 'Password',isPassword: true,textColor: 0xff1B5E4C,lablelColor: 0xff1B5E4C,),
                  SizedBox(height: 20,),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () async{
                        //Implement login functionality.
                        setState(() {
                          showSpinner = true;
                        });
                        try{
                          final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if (newUser!=null){
                            //Navigator.pushNamed(context, SignUp.id);
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Your transaction was successful!",

                            );
                           // getData(context);
                            Navigator.pushNamed(context, BottomNavigationScreen.id);
                          }

                        }catch(e){
                          print(e);
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: "ERROR!",
                          );
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Login',
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
                        'Not Registered ?  ',
                        style: TextStyle(color: Color(0xff5caa8b)),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignUp.id);
                        },
                        child: Text(
                          'Register here ',
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
