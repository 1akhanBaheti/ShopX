import 'package:ecommerce/Componenets/SelectQuantity.dart';
import 'package:ecommerce/checkoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
//   const
// CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var isLoading;
  var qty;
  @override
  void initState() {
    super.initState();

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((value) {
    //   value.data()!.forEach((key, value) {
    //     if (key == 'address') address = value;
    //   });
    //   print(address);
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('ran');
    var address;
    //final ctx = context;

    var delivery =
        DateFormat('E LLL d ').format(DateTime.now().add(Duration(days: 3)));
    //var cartItems = Provider.of<provider>(context, listen: true);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: true);
    //var appbar = AppBar();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Container(
            child: Text(
              'Order Summary',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        body: FutureBuilder(
          future: checkoutProvider.getaddress(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              address = checkoutProvider.particularAdress;
              return SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1,
                          color: Colors.grey.shade200,
                        ),
                        Container(
                          color: Colors.white,
                          height: 60,
                          width: double.infinity,
                          // color: Colors.amber,
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: SvgPicture.asset(
                                  'assets/images/orderSummary.svg')),
                        ),
                        Container(
                          color: Colors.grey.shade200,
                          height: 10,
                        ),
                        Container(
                          // height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text('${address['Fullname']}',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 19,
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                    '${address['Flat,House no,Building,Company,Apartment']}, ${address['Area,Colony,Street,Sector,Village']}, ${address['Landmark']}',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 1),
                                child: Text('${address['State']}',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 1),
                                child: Text(
                                    '${address['City']}-${address['Pincode']}',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 7),
                                child: Text('${address['Mobilenumber']}',
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('toChangeOrAddAddressScreen');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 10),
                            height: 40,
                            width: double.infinity,
                            child: Center(
                              child: Text('Change or Add Address',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade200,
                          height: 10,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: checkoutProvider.checkoutItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                margin: EdgeInsets.only(left: 260),
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  size: 40,
                                ),
                              ),
                              key: Key(checkoutProvider
                                  .checkoutItems[index].productClass.title),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      // height: 150,
                                      // margin: EdgeInsets.all(5),
                                      // color: Colors.deepOrange,
                                      child: Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              //color: Colors.amber,
                                              margin: EdgeInsets.only(
                                                bottom: 8,
                                                top: 1,
                                              ),
                                              width: 130,
                                              height: 100,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Image.network(
                                                    checkoutProvider
                                                        .checkoutItems[index]
                                                        .productClass
                                                        .imageUrl),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (_) => SelectQuantity(
                                                        context,
                                                        index,
                                                        checkoutProvider
                                                            .checkoutItems[
                                                                index]
                                                            .cartCounter)).then(
                                                    (value) {
                                                  setState(() {});
                                                });

                                                // ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text('lakhan'), actions: []));
                                                //Scaffold.of(context).showBottomSheet((context) =>Container(height: 50,)
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0),
                                                        padding:
                                                            EdgeInsets.all(6),
                                                        child: Text(
                                                            'Qty: ${checkoutProvider.checkoutItems[index].cartCounter}',
                                                            style: GoogleFonts.lato(
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: Icon(Icons
                                                          .arrow_drop_down),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          // color: Colors.deepOrange,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "${checkoutProvider.checkoutItems[index].productClass.title}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 17,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "${checkoutProvider.checkoutItems[index].productClass.category}",
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade800,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      width: 40,
                                                      margin: EdgeInsets.only(
                                                          left: 8, top: 3),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Text(
                                                            '4 ',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          Container(
                                                            child: Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                        child: Text(
                                                      '  (21,979)',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ]),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "\$" +
                                                      "${checkoutProvider.checkoutItems[index].productClass.price * checkoutProvider.checkoutItems[index].cartCounter}",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),

                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 8, bottom: 15),
                                                  child: Text(
                                                      'Delivery by $delivery')
                                                  //   'Delivery by ${delivery.weekday} ${delivery.month} ${delivery.day} '),
                                                  )
                                              // SizedBox(
                                              //   height: 25,
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ])),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 2,
                                    color: Colors.grey[200],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          color: Colors.grey.shade200,
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Container(
                                  height: 40,
                                  // color: Colors.amber,
                                  // margin: EdgeInsets.only(left:15),
                                  padding: EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                    'PRICE DETAILS',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey.shade200,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                'Price(${checkoutProvider.checkoutItems.length} item)',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18))
                                      ])),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: Text(
                                        '\$${checkoutProvider.checkoutTotal}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Delivery Charges',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18))
                                      ])),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: Text(
                                        'FREE',
                                        style: TextStyle(
                                            color: Colors.green.shade800,
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey.shade300,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Total',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: Text(
                                        '\$${checkoutProvider.checkoutTotal}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                color: Colors.grey.shade200,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('toPaymentScreen');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber.shade600,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Center(
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
                strokeWidth: 2,
              ),
            );
          },
        ));
  }
}
