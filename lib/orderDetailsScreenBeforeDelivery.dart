import 'package:ecommerce/Componenets/Drawer.dart';
import 'package:ecommerce/orderDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreenBeforeDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(UniqueKey());
    var item = ModalRoute.of(context)!.settings.arguments as ORDER;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      //drawer: Drawer1(context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 0,
              ),
              height: 1,
              color: Colors.grey.shade200,
            ),
            SizedBox(
              //color: Colors.green,
              height: 50,
              child: Center(
                child: RichText(
                    text: TextSpan(

                      children: [
                  TextSpan(
                      text: 'ORDER ID -',
                      style: GoogleFonts.lato(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '4875674382298642726426472',
                      style: GoogleFonts.lato(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.normal)),
                ])),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
              ),
              height: 1,
              color: Colors.grey.shade200,
            ),
            SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        // color: Colors.deepOrange,
                        width: MediaQuery.of(context).size.width - 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "${item.product.title}",
                                style: GoogleFonts.roboto(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 5,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "${item.product.category}",
                                style: GoogleFonts.roboto(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                "\$" +
                                    "${item.product.price * item.cartCounter}",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.amber,
                            margin: EdgeInsets.only(
                              bottom: 8,
                              top: 1,
                            ),
                            width: 130,
                            height: 90,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(item.product.imageUrl),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 0),
                                    padding: EdgeInsets.all(6),
                                    child: Text('Qty: ${item.cartCounter}',
                                        style: GoogleFonts.lato(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 20, right: 10),
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(100)),
                        width: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text('Ordered',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: 0,
                        left: 23,
                      ),
                      height: 80,
                      width: 3,
                      color: Colors.grey.shade300),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 20, right: 10),
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(100)),
                        width: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text('Delivery',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                    ),
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
