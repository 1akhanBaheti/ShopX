import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';

// ignore: must_be_immutable
class Account extends StatefulWidget {
  var he;
  //Account(BuildContext this.he);

  // const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser);
    print('Account');
    // print(FirebaseAuth.instance.currentUser!.phoneNumber);
    var authProvider = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Account',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      //drawer: Drawer1(context),
      body: FirebaseAuth.instance.currentUser != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('toUserInfoEditScreen');
                                },
                                child: Container(
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
                              ),
                              Container(
                                //color: Colors.amber,
                                height: 140,

                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: 60,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Icon(
                                          Icons.account_circle,
                                          size: 120,
                                          color: Colors.deepPurple.shade300,
                                        )),
                                    // backgroundImage: NetworkImage(
                                    //     "https://image.flaticon.com/icons/png/512/1077/1077114.png"),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    '${FirebaseAuth.instance.currentUser!.displayName}',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Container(
                                  child: Text(
                                    '${FirebaseAuth.instance.currentUser!.email}',
                                    style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FirebaseAuth.instance.currentUser!.phoneNumber ==
                                      ''
                                  ? Center(
                                      child: Container(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Mobile no:',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: ' not added',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))
                                            ],
                                            // style: GoogleFonts.lato(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Mobile no:',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: ' not added',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black))
                                            ],
                                            // style: GoogleFonts.lato(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('toChangeOrAddAddressScreen');
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 18, left: 14),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Address',
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
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
                      'Security',
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> orders = {};
                      await FirebaseDatabase.instance
                          .reference()
                          .child('Orders')
                          .once()
                          .then((value) {
                        orders = value.value as Map<String, dynamic>;
                      });
                      orders.forEach((key, value) {
                        if (key ==
                            FirebaseAuth.instance.currentUser!.displayName) {
                          var temp = {};
                          temp = value;
                          temp.addEntries({
                            
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 18, left: 14),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Message',
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
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
                        fontSize: 20,
                      ),
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
                      style:
                          GoogleFonts.lato(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FirebaseAuth.instance.currentUser != null
                      ? Stack(
                          children: [
                            Container(
                              height: 60,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurple)),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  authProvider.logOut().then((value) {
                                    if (value) {
                                      print(value);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Succesfully Logout')));
                                    }
                                  }).catchError((e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                'Something went wrong please try again '),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          );
                                        });
                                  });
                                },
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            isLoading
                                ? Container(
                                    color: Colors.white,
                                    height: 60,
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        )
                      : Container()
                  // Container(
                  //     height: 60,
                  //     margin: EdgeInsets.only(left: 20, right: 20),
                  //     width: MediaQuery.of(context).size.width,
                  //     child: ElevatedButton(
                  //       style: ButtonStyle(
                  //           backgroundColor:
                  //               MaterialStateProperty.all(
                  //                   Colors.deepPurple)),
                  //       onPressed: null,
                  //       child: Text(
                  //         'Login',
                  //         style: TextStyle(
                  //             fontSize: 18, color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    //color: Colors.amber,
                    height: MediaQuery.of(context).size.height * .50,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .2),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset('assets/images/doors.jpg'),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        'Your are not Logged In',
                        style: GoogleFonts.lato(
                          color: Colors.grey.shade800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        'please Log in!',
                        style: GoogleFonts.lato(
                          color: Colors.grey.shade800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('toMainoptions');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 60,
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Log in',
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
