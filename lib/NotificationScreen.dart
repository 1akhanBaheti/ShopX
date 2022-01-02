
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  //const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
      ),
      
      body: Container(
        child: Center(
          child:
          Text('NOTIFICATIONS',)
        ),
      ),
    );
  }
}