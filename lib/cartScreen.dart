//import 'dart:html';

import 'dart:ui';

import 'package:ecommerce/Componenets/Drawer.dart';
import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/checkoutProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<provider>(context, listen: true);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: true);

    print("BUILDED");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Your Bag',
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      // drawer: Drawer1(context),
      body: FutureBuilder(
          future: cartItems.getCartItems(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (cartItems.cartitems.length != 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Container(
                      height: 8,
                    ),
                    Container(
                      //height: 50,
                      child: Row(children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Subtotal:',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "\$" + '${cartItems.cartTotal}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )),
                      ]),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(children: [
                      Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Icon(Icons.info)),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            'You are eligible for Free Delivery',
                            style: TextStyle(
                                color: Colors.green.shade800,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ]),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 15),
                      child: ElevatedButton(
                        child: Text(
                          "Proceed to Buy (${cartItems.cartitems.length} items)",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        onPressed: () async {
                          await checkoutProvider.getaddress().then((value) {
                            if (checkoutProvider.address.length == 0) {
                              Navigator.pushNamed(
                                  context, 'Base_delievery_address');
                            }
                          });

                          await checkoutProvider
                              .updateCheckoutItems(cartItems.temp)
                              .then((value) => Navigator.pushNamed(
                                  context, 'toCheckoutScreen'));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                      ),
                    ),
                    Container(height: 4, color: Colors.grey[200]),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemCount: cartItems.cartitems.length,
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
                              key: Key(cartItems
                                  .cartitems[index].productClass.title),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 160,
                                      margin: EdgeInsets.all(5),
                                      // color: Colors.deepOrange,
                                      child: Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.amber,
                                              margin: EdgeInsets.only(
                                                bottom: 8,
                                                top: 1,
                                              ),
                                              width: 130,
                                              height: 100,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Image.network(cartItems
                                                    .cartitems[index]
                                                    .productClass
                                                    .imageUrl),
                                              ),
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
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "${cartItems.cartitems[index].productClass.title}",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 17,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "${cartItems.cartitems[index].productClass.category}",
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.grey,
                                                        fontSize: 17,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "\$" +
                                                          "${cartItems.cartitems[index].productClass.price}",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          margin: EdgeInsets.only(left: 20),
                                          child: Row(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // padding: EdgeInsets.all(10),
                                                  //color:Colors.amber,
                                                  width: 45,
                                                  height: 35,
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                          .grey[
                                                                      200]),
                                                          shape: MaterialStateProperty
                                                              .all(
                                                                  RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey),
                                                          ))),
                                                      onPressed: () async {
                                                        await cartItems
                                                            .addcartItems(index)
                                                            .then(
                                                                (value) => null)
                                                            .catchError((e) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      '$e.message')));
                                                        });
                                                      },
                                                      child: SvgPicture.asset(
                                                          'assets/images/plus.svg')),
                                                ),
                                                Consumer<provider>(builder:
                                                    ((ctx, parent, child) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1)),
                                                    width: 55,
                                                    height: 35,
                                                    child: Center(
                                                        child: Text(
                                                      '${parent.cartitems[index].cartCounter}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    )),
                                                  );
                                                })),
                                                Container(
                                                    width: 45,
                                                    height: 35,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                            .grey[
                                                                        200]),
                                                            shape: MaterialStateProperty
                                                                .all(
                                                                    RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey),
                                                            ))),
                                                        onPressed: () {
                                                          cartItems
                                                              .removecartItems(
                                                                  index);
                                                        },
                                                        child: SvgPicture.asset(
                                                            'assets/images/minus.svg'))),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await cartItems
                                                    .addToSaveForLater(cartItems
                                                        .cartitems[index])
                                                    .then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Saved for later')));
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                padding: EdgeInsets.all(5),
                                                margin:
                                                    EdgeInsets.only(left: 15),
                                                height: 35,
                                                width: 90,
                                                child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child:
                                                        Text('save for later')),
                                              ),
                                            )
                                          ]),
                                        )
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
                      ),
                    ),
                    cartItems.saveForLater.length != 0
                        ? Container(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 15, left: 15, bottom: 20),
                                child: Text(
                                  'Saved For Later',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ////////////////////////////////////////////////////////////////////////////
                              ///
                              ListView.builder(
                                itemBuilder: (ctx, index) {
                                  return Container(
                                      height: 160,
                                      //margin: EdgeInsets.all(5),
                                      // color: Colors.deepOrange,
                                      child: Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.amber,
                                              margin: EdgeInsets.only(
                                                bottom: 8,
                                                top: 1,
                                              ),
                                              width: 130,
                                              height: 100,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Image.network(cartItems
                                                    .saveForLater[index]
                                                    .imageUrl),
                                              ),
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
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "${cartItems.saveForLater[index].title}",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 17,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "${cartItems.saveForLater[index].category}",
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.grey,
                                                        fontSize: 17,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      "\$" +
                                                          "${cartItems.saveForLater[index].price}",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await cartItems
                                                      .moveToCartFromSavedForLater(
                                                          index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: BorderDirectional(
                                                        end: BorderSide(
                                                            color: Colors.grey
                                                                .shade400)),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  // margin: EdgeInsets.only(left:10),
                                                  //height: 35,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Center(
                                                    child: Text(
                                                      'move to cart',
                                                      style: GoogleFonts.lato(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await cartItems
                                                      .removeFromSavedForLater(
                                                          index);
                                                },
                                                child: Container(
                                                  color: Colors.grey.shade200,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  //  height: 35,
                                                  child: Center(
                                                    child: Text(
                                                      'remove',
                                                      style: GoogleFonts.lato(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]));
                                },
                                shrinkWrap: true,
                                itemCount: cartItems.saveForLater.length,
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                height: 2,
                                color: Colors.grey[200],
                              ),
                            ],
                          ))
                        : Container(),
                  ],
                );
              } else if (cartItems.saveForLater.length != 0 &&
                  cartItems.cartitems.length == 0) {
                {
                  return Container(
                      // margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 15, bottom: 20),
                        child: Text(
                          'Saved For Later',
                          style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      //////////////////////////////(//////////////////////////////////////////////
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartItems.saveForLater.length,
                          itemBuilder: (ctx, index1) {
                            return Container(
                                margin: EdgeInsets.only(bottom: 15),
                                height: 160,
                                //margin: EdgeInsets.all(5),
                                // color: Colors.deepOrange,
                                child: Column(children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.amber,
                                        margin: EdgeInsets.only(
                                          bottom: 8,
                                          top: 1,
                                        ),
                                        width: 130,
                                        height: 100,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Image.network(cartItems
                                              .saveForLater[index1].imageUrl),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.deepOrange,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                "${cartItems.saveForLater[index1].title}",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 17,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                "${cartItems.saveForLater[index1].category}",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.grey,
                                                  fontSize: 17,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                "\$" +
                                                    "${cartItems.saveForLater[index1].price}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cartItems
                                                .moveToCartFromSavedForLater(
                                                    index1);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: BorderDirectional(
                                                  end: BorderSide(
                                                      color: Colors
                                                          .grey.shade400)),
                                              color: Colors.grey.shade200,
                                            ),
                                            // margin: EdgeInsets.only(left:10),
                                            //height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Center(
                                              child: Text(
                                                'move to cart',
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await cartItems
                                                .removeFromSavedForLater(
                                                    index1);
                                          },
                                          child: Container(
                                            color: Colors.grey.shade200,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            //  height: 35,
                                            child: Center(
                                              child: Text(
                                                'remove',
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]));
                          }),

                      // Container(
                      //   margin: EdgeInsets.only(left: 10, right: 10,bottom: 0),
                      //   height: 2,
                      //   color: Colors.grey[200],
                      // ),
                    ],
                  ));
                }
              } else
                return Container(
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 1, color: Colors.grey.shade200),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        width: double.infinity,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.asset(
                              'assets/images/cart.png',
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'Your Cart is Empty',
                          style: GoogleFonts.lato(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                        child: Text(
                          'Looks like you haven\'t added anything in your cart yet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontSize: 18, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                );
            }

            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Colors.amber,
              ),
            );
          }),
    );
  }
}
