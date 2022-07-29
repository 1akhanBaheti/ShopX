import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';

class MainSignupLogin extends StatefulWidget {
  //const MainSignupLogin({Key? key}) : super(key: key);

  @override
  State<MainSignupLogin> createState() => _MainSignupLoginState();
}

class _MainSignupLoginState extends State<MainSignupLogin> {
  var emailNotValid = false;
    
   @override
  void initState() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
   
    statusBarColor: Colors.teal.shade400, // status bar color
  ));
    super.initState();
  }
  var email = TextEditingController();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
   
    statusBarColor: Colors.teal.shade400, // status bar color
  ));
    
    var height = MediaQuery.of(context).size.height;
    var authProvider = Provider.of<Auth>(context);

    var focus = FocusScope.of(context);

    print('MAINOPTION');
  
    return Scaffold(
      
     
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
       
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (!focus.hasPrimaryFocus) focus.unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              
              alignment: Alignment.bottomCenter,
              height: height,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 23),
                        child: Text(
                          'Hi!',
                          style: GoogleFonts.ptSans(
                              fontSize: 50,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.2)),
                        // height: height - height * 0.2,
                        margin: EdgeInsets.only(top: 17, right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  //color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 0),
                              height: 60,
                              child: TextFormField(
                                onChanged: (e) {
                                  if (emailNotValid)
                                    setState(() {
                                      emailNotValid = false;
                                    });
                                },
                                controller: email,
                                cursorColor: Colors.black87,
                                cursorHeight: 18,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Email',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade400,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            emailNotValid
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 18),
                                    child: Text('* Not valid email',
                                        style: GoogleFonts.lato(
                                            color: Colors.red, fontSize: 16)),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                  ),
                            InkWell(
                              onTap: () async {
                                print('clicked');
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                if (!email.text.contains('@gmail.com')) {
                                  setState(() {
                                    emailNotValid = true;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await authProvider
                                      .checkEmailExist(email.text)
                                      .then((value) {
                                    if (value == false) {
                                      print('TRUEM');
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.of(context).pushNamed(
                                          "toSignInScreen",
                                          arguments: email.text);
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.of(context).pushNamed(
                                          "toSignupScreen",
                                          arguments: email.text);
                                    }
                                  }).catchError((e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(e.toString());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('${e.message}')));
                                  });

                                  //////////////////////////////
                                  //     .then((value) {
                                  //   if (value == true) {
                                  //     setState(() {
                                  //       isLoading = false;
                                  //     });
                                  //     Navigator.of(context).pushNamed(
                                  //         "toSignInScreen",
                                  //         arguments: email.text);
                                  //   } else
                                  //   {
                                  //     setState(() {
                                  //       isLoading = false;
                                  //     });
                                  //       Navigator.of(context).pushNamed(
                                  //         "toSignupScreen",
                                  //         arguments: email.text);

                                  //   }

                                  // });
                                }
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
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
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Center(
                                child: Text(
                                  'or',
                                  style: GoogleFonts.lato(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      width: 40,
                                      height: 30,
                                      child: FittedBox(
                                          child: Image.asset(
                                              'assets/images/facebook.png'),
                                          fit: BoxFit.contain),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        'Continue with Facebook',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      padding: EdgeInsets.only(left: 15),
                                      height: 30,
                                      child: FittedBox(
                                          child: Image.asset(
                                              'assets/images/google.png'),
                                          fit: BoxFit.contain),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        'Continue with Google',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      padding: EdgeInsets.only(left: 15),
                                      height: 30,
                                      child: FittedBox(
                                          child: Image.asset(
                                              'assets/images/apple.png'),
                                          fit: BoxFit.contain),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        'Continue with Apple',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, left: 23),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "Don\'t have an account?  ",
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Sign up",
                                      style: GoogleFonts.lato(
                                          color: Colors.teal.shade400,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(bottom: 15, left: 23),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         child: Text(
                            //           "Already have an account?  ",
                            //           style: GoogleFonts.lato(
                            //               color: Colors.white, fontSize: 18),
                            //         ),
                            //       ),
                            //       Container(
                            //         child: Text(
                            //           "Sign in",
                            //           style: GoogleFonts.lato(
                            //               color: Colors.deepPurple,
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, left: 23),
                              child: Text(
                                "Forgot your password?",
                                style: GoogleFonts.lato(
                                    color: Colors.teal.shade400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
         Container(
          margin: EdgeInsets.only(
              top: 15, left: MediaQuery.of(context).size.width - 50),
          child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('toMainScreen', (route) => false);
              },
              child: Text('Skip',style: TextStyle(color: Colors.teal.shade400),)),
        ),
        isLoading
            ? Container(
                color: Colors.white.withOpacity(0.3),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.teal.shade400,
                )),
              )
            : Container()
      ]),
    );
  }
}
