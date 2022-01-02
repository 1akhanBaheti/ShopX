import 'package:ecommerce/authentication.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  // const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var name = TextEditingController();

  var password = TextEditingController();

  var nameNotValid = false;
  var isLoading = false;
  var passNotValid = false;

  @override
  Widget build(BuildContext context) {
   
    var auth = Provider.of<Auth>(context);
    var height = MediaQuery.of(context).size.height;
    var email = ModalRoute.of(context)!.settings.arguments as String;
    var focus = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (!focus.hasPrimaryFocus) focus.unfocus();
          },
          child: Container(
            height: height,
            width: double.infinity,
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(top: height * 0.2, left: 23),
                    child: Text(
                      'Sign up',
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
                          margin: EdgeInsets.only(top: 20, left: 20),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: '${email}',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    )),
                              ],
                              text:
                                  'Looks like you don\' have an account \nLets create a new account for \n',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          height: 60,
                          child: TextFormField(
                            onChanged: (e) {
                              if (nameNotValid)
                                setState(() {
                                  nameNotValid = false;
                                });
                            },
                            controller: name,
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
                              hintText: 'Name',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepPurple, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        nameNotValid
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 18),
                                child: Text('* Not valid Name',
                                    style: GoogleFonts.lato(
                                        color: Colors.red, fontSize: 16)),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 20),
                              ),
                        Container(
                          decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: 0, left: 20, right: 20, bottom: 0),
                          height: 60,
                          child: TextFormField(
                            onChanged: (e) {
                              if (passNotValid)
                                setState(() {
                                  passNotValid = false;
                                });
                            },
                            controller: password,
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
                              hintText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepPurple, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        passNotValid
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 18),
                                child: Text('* This field is must',
                                    style: GoogleFonts.lato(
                                        color: Colors.red, fontSize: 16)),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 20),
                              ),
                        Container(
                            margin:
                                EdgeInsets.only(top: 0, left: 20, bottom: 20),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text:
                                          'Terms of Service and Privacy Policy ',
                                      style: GoogleFonts.lato(
                                          color: Colors.deepPurple,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal)),
                                ],
                                text:
                                    'By selecting Agree and continue below \nI agree to ',
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            print('TAPED');
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (name.text == '')
                              setState(() {
                                nameNotValid = true;
                              });

                            if (password.text == '')
                              setState(() {
                                passNotValid = true;
                              });
                            else {
                              print('else');
                              setState(() {
                                isLoading = true;
                              });
                              auth.Signup(email, password.text,name.text)
                                  .then((_) {
                                isLoading = false;
                                Navigator.of(context)
                                    .pushReplacementNamed('toMainScreen');
                              });
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
                      ],
                    ),
                  ),
                ]),
                isLoading
                    ? Stack(
                        children: [
                          Container(
                            color: Colors.white.withOpacity(0.5),
                            height: height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
