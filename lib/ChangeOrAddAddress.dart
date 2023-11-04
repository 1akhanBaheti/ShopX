import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'checkoutProvider.dart';

// ignore: must_be_immutable
class ChangeOrAddAdress extends StatelessWidget {
  //const ChangeOrAddAdress({Key? key}) : super(key: key);
  var address = [];
  @override
  Widget build(BuildContext context) {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Your Adresses',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: checkoutProvider.getaddress(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                address = checkoutProvider.address;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('Base_delievery_address');
                        },
                        child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Add a new address',
                                      style: GoogleFonts.lato(
                                          color: Colors.black, fontSize: 18),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )
                              ],
                            )),
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      address.isNotEmpty?Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'Personal Addresses',
                            style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          )):Container(),
                      Container(
                        child: ListView.builder(
                            itemCount: address.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  checkoutProvider
                                      .updateParticularAddress(address[index]);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(6)),
                                  // height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                            '${address[index]['Fullname']}',
                                            style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                            '${address[index]['Flat,House no,Building,Company,Apartment']}, ${address[index]['Area,Colony,Street,Sector,Village']}, ${address[index]['Landmark']}',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 1),
                                        child:
                                            Text('${address[index]['State']}',
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                )),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 1),
                                        child: Text(
                                            '${address[index]['City']}-${address[index]['Pincode']}',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 7),
                                        child: Text(
                                            '${address[index]['Mobilenumber']}',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 16,
                                            )),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(15),
                                              height: 40,
                                              width: 100,
                                              child: Card(
                                                elevation: 4,
                                                shape: BeveledRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child:
                                                    Center(child: Text('Edit')),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(15),
                                              height: 40,
                                              width: 100,
                                              child: Card(
                                                elevation: 4,
                                                shape: BeveledRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Center(
                                                    child: Text('Remove')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                  strokeWidth: 2,
                ),
              );
            }));
  }
}
