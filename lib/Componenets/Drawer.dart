import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Drawer1 extends StatelessWidget {
  var he;
  Drawer1(this.he);

  // const Drawer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // var firebaseProvider = Provider.of<FirebaseProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 125,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
              child: Container(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 8),
                          child: FirebaseAuth.instance.currentUser != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ShopName',
                                      style: GoogleFonts.lato(
                                        color: Colors.deepPurple,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${FirebaseAuth.instance.currentUser!.displayName!.toUpperCase()}',
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${FirebaseAuth.instance.currentUser!.email}',
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    FirebaseAuth.instance.currentUser!
                                                .phoneNumber !=
                                            ''
                                        ? Text(
                                            '9685628805',
                                            style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.7 -
                                          85,
                                      child: Text(
                                        'shopName User',
                                        style: GoogleFonts.lato(
                                            color: Colors.deepPurple,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                )
                              : Container()),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 4),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 4, bottom: 5),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
          InkWell(
              onTap: () {
                Navigator.of(he)
                    .pushNamedAndRemoveUntil('toMainScreen', (route) => false);
                // Navigator.pushNamed(context, 'toMainoptions');
              },
              // onTap: () {
              //   Navigator.pushReplacement(
              //       context, MaterialPageRoute(builder: (ctx) => Account(he)));

              //   // Navigator.pushNamed(context, 'toMainoptions');
              // },
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.home_filled,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13),
                      child: Text(
                        'Home',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(he).pushNamed('toOrdersScreen');
              // Navigator.pushNamed(context, 'toMainoptions');
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 17,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.shopping_basket,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    child: Text(
                      'Your Orders',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(he).pushNamed('toAccount');
              // Navigator.pushNamed(context, 'toMainoptions');
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 17,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    child: Text(
                      'Your Account',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(he).pushNamed('toFavouriteScreen');
              // Navigator.pushNamed(context, 'toMainoptions');
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 17,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    child: Text(
                      'Your WishList',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(he).pushNamed('toCartScreen');
              // Navigator.pushNamed(context, 'toMainoptions');
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 17,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    child: Text(
                      'Your Cart',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            //color: Colors.amber,
            width: double.infinity,
            decoration: BoxDecoration(
                //color: Colors.amber,
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            padding: EdgeInsets.only(
              left: 12,
            ),
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(he).pushNamed('trial');
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'About Us',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
