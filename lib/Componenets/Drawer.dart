import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Drawer1 extends StatelessWidget {
  var he;
  Drawer1(this.he);

  // const Drawer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: Column(
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
                              'LAKHAN BAHETI',
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'lakhanbaheti9@gmail.com',
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '9685628805',
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.7 - 85,
                              child: Text(
                                'shopName User',
                                style: GoogleFonts.lato(
                                    color: Colors.deepPurple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
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
              Navigator.of(he).pushNamed('toMainoptions');
              // Navigator.pushNamed(context, 'toMainoptions');
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              //color: Colors.amber,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                      top: BorderSide(color: Colors.grey.shade200))),
              padding: EdgeInsets.only(left: 12, top: 10),
              height: 45,
              child: Text(
                'Orders',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
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
                Container(
                  width: double.infinity,
                  child: Text(
                    'About Us',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.lato(
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
