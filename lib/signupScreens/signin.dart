import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var email = ModalRoute.of(context)!.settings.arguments as String;
    var focus = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (!focus.hasPrimaryFocus) focus.unfocus();
        },
        child: Container(
          height: height,
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.2, left: 23),
              child: Text(
                'Log in',
                style: GoogleFonts.ptSans(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.8)),
              // height: height - height * 0.2,
              margin: EdgeInsets.only(top: 17, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                   
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 23,top: 10),
                         child:CircleAvatar(
                           child:Icon(Icons.person),

                           radius: 35,
                           backgroundColor: Colors.white,
                         )
                        ),
                       
                            Center(
                              child: Container(
                               
                          margin: EdgeInsets.only( left: 20),
                          child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(

                                      text: 'lakhanbaheti9@gmail.com',
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                                text:
                                    'Lakhan Baheti\n',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w900,
                                    color: Colors.white, fontSize: 18),
                              ),
                          ),
                        ),
                            ),
                          
                      
                        
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    height: 60,
                    child: TextFormField(
                      cursorColor: Colors.black87,
                      cursorHeight: 18,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: null, icon: Icon(Icons.hide_source)),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'continue',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.only(bottom: 20, left: 23,top:10),
                    child: Text(
                      "Forgot your password?",
                      style: GoogleFonts.lato(
                          color: Colors.teal.shade300,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
