import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  // const category({Key? key}) : super(key: key);
  String name;
  List<Color> col;
  Categories(
    this.name,
    this.col
  );
  @override
  Widget build(BuildContext context) {
    return Column(
    children:[
    Container(
         //height: 90,
         height: 70,
       //  width:70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      gradient: LinearGradient(
        colors:col,

       begin: Alignment.topLeft,
        end: Alignment.bottomRight

      )
    ),
    // color: col,

        child: Center(
          child: Text(name,style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
        ),
      
      //  Stack(
      //   children: [
      //     Text(name),
      //   ],
      // ),
    
    ),

    Container(
      child: Text(name,style:GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.bold)),
    )
    ],
    );
  }
}
