import 'dart:async';

import 'package:flutter/material.dart';


class Splashscreen extends StatefulWidget {
 // splashScreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}



class _SplashscreenState extends State<Splashscreen> {
  
  @override
void initState() { 
 super.initState();
  
  Timer(Duration(seconds: 3), (){
  
  Navigator.of(context,rootNavigator: true).pushReplacementNamed('toMainScreen');
  });
   
}
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body:
      Center(
        child:
         Text('HELLO LAKHAN',style: TextStyle(color: Colors.black,fontSize: 26),),
      ),
  );
  }
}