import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/adressDataModel.dart';
import 'package:ecommerce/orderDataModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreenBeforeDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _address = "";
    void addressFormatter(ADDRESS a) {
      _address += a.fullName + "\n";
      _address += a.flatHousenoBuildingCompanyApartment + "\n";
      _address += a.areaColonyStreetSectorVillage + "\n";
      _address += a.landmark + "\n";
      _address += a.city + "\n";
      _address += a.state + "\n";
      _address += a.pincode + "\n";
    }

    //print(UniqueKey());
    var item = ModalRoute.of(context)!.settings.arguments as ORDER;
    addressFormatter(item.address);
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                height: 1,
                color: Colors.grey.shade200,
              ),
              // SizedBox(
              //   //color: Colors.green,
              //   height: 50,
              //   child: Center(
              //     child: RichText(
              //         text: TextSpan(children: [
              //       TextSpan(
              //           text: 'ORDER ID -',
              //           style: GoogleFonts.lato(
              //               color: Colors.grey.shade400,
              //               fontWeight: FontWeight.bold)),
              //       TextSpan(
              //           text: '4875674382298642726426472',
              //           style: GoogleFonts.lato(
              //               color: Colors.grey.shade400,
              //               fontWeight: FontWeight.normal)),
              //     ])),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          'Order Date',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                              fontSize: 19, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 15),
                        child: Text(
                          'Order Id',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                              fontSize: 19, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 15),
                        child: Text(
                          'Total',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                              fontSize: 19, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          item.Date,
                          style: GoogleFonts.lato(
                              fontSize: 19, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 15),
                        child: Text(
                          '216712431',
                          style: GoogleFonts.lato(
                              fontSize: 19, color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 15),
                        child: Text(
                         '₹'+item.totalPrice.toString(),
                          style: GoogleFonts.lato(
                              fontSize: 19, color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
        SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(
                  bottom: 8,
                ),
                height: 1,
                color: Colors.grey.shade200,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: item.products.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return SizedBox(
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
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${item.products[index].productClass.title}",
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 5,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${item.products[index].productClass.category}",
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
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "₹"
                                        "${item.products[index].productClass.price * item.products[index].cartCounter}",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 0, bottom: 15),
                                      //decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey)),
                                      child: Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 0, left: 5),
                                              padding: EdgeInsets.all(6),
                                              child: Text(
                                                  'Qty: ${item.products[index].cartCounter}',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 17,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ],
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
                                        child: CachedNetworkImage(
                                            imageUrl: item.products[index]
                                                .productClass.imageUrl)),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 5, bottom: 15),
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(color: Colors.grey)),
                                  //   child: Row(
                                  //     children: [
                                  //       Container(
                                  //           margin: EdgeInsets.only(top: 0),
                                  //           padding: EdgeInsets.all(6),
                                  //           child: Text(
                                  //               'Qty: ${item.products[index].cartCounter}',
                                  //               style: GoogleFonts.lato(
                                  //                   fontSize: 17,
                                  //                   color: Colors.black,
                                  //                   fontWeight:
                                  //                       FontWeight.bold))),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 1,
                            color: Colors.grey.shade200,
                          ),
                        ]));
                  }),
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
              // Container(
              //   height: 50,
              //   child: Center(
              //     child: Text(
              //       'Cancel',
              //       style: GoogleFonts.lato(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 20),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(
                  top: 0,
                ),
                height: 1,
                color: Colors.grey.shade200,
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 15),
                child: Text(
                  'Shipping Address',
                  style: GoogleFonts.lato(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 15),
                child: Text(
                  _address,
                  style: GoogleFonts.ptSans(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0,
                ),
                height: 1,
                color: Colors.grey.shade200,
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 8, left: 15),
              //   child: Text(
              //     'Order Summary',
              //     style: GoogleFonts.lato(
              //         fontSize: 24,
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
