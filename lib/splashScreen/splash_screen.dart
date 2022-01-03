import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_ovqat_customer/authentication/auth_screen.dart';
import 'package:my_ovqat_customer/global/global.dart';
import 'package:my_ovqat_customer/mainScreen/home_screen.dart';



class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}


class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){

    Timer(const Duration(seconds: 6), () async {
      if(firebaseAuth.currentUser != null){
        // if the user is already logged in this takes to the homePage instead of Registration Page
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      // if not logged in it goes to the registration page
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }

    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey,
              Colors.white,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/welcome.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Order in My Ovqat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:  Colors.blueAccent,
                    fontSize: 40,
                    fontFamily: "Train",
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
