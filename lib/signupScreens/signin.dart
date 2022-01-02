import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';

class Signin extends StatefulWidget {
  //const Signin({Key? key}) : super(key: key);
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var password = TextEditingController();

  var isLoading = false;
  var passwordIncorrect = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth>(context);
    var height = MediaQuery.of(context).size.height;
    var email = ModalRoute.of(context)!.settings.arguments as String;
    var focus = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Stack(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (!focus.hasPrimaryFocus) focus.unfocus();
            },
            child: Container(
              height: height,
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    margin: EdgeInsets.only(left: 23, top: 10),
                                    child: CircleAvatar(
                                      child: Icon(Icons.person),
                                      radius: 35,
                                      backgroundColor: Colors.white,
                                    )),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: email,
                                              style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        ],
                                        text: 'Lakhan Baheti\n',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            fontSize: 18),
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
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            height: 60,
                            child: TextFormField(
                              controller: password,
                              cursorColor: Colors.black87,
                              cursorHeight: 18,
                              onChanged: (e) {
                                if (passwordIncorrect)
                                  setState(() {
                                    passwordIncorrect = false;
                                  });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                suffixIcon: IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.hide_source)),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Password',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          passwordIncorrect
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 18),
                                  child: Text('*Password is Incorrect',
                                      style: GoogleFonts.lato(
                                          color: Colors.red, fontSize: 16)),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                ),
                          InkWell(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              setState(() {
                                isLoading = true;
                              });
                              await authProvider
                                  .signIn(email, password.text)
                                  .then((value) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'toMainScreen', (route) => false);
                              }).catchError((e) {
                                setState(() {
                                  isLoading = false;
                                  
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${e.message}')));
                              });
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
                            margin:
                                EdgeInsets.only(bottom: 20, left: 23, top: 10),
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
          isLoading
              ? Container(
                  color: Colors.white.withOpacity(0.3),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.teal.shade400,
                  )),
                )
              : Container()
        ],
      )),
    );
  }
}
