import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatelessWidget {
  // const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 40),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'My Account',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height -142,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 260,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.deepPurple,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.deepPurple.withOpacity(0.1),
                          height: 260,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                width: MediaQuery.of(context).size.width,
                                height: 20,
                                child: Text(
                                  "Edit",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                //color: Colors.amber,
                                height: 140,

                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        "https://image.flaticon.com/icons/png/512/1077/1077114.png"),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    'Name',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    'Email address',
                                    style: GoogleFonts.lato(fontSize: 22),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    'Mobile no.',
                                    style: GoogleFonts.lato(fontSize: 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Your orders',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Address',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Message',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Setting',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Setting',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Payment Methods',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Terms & Conditions',
                      style: GoogleFonts.lato(
                          fontSize: 20,),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 18, left: 14),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'About Us',
                      style: GoogleFonts.lato(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple)),
                      onPressed: null,
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
