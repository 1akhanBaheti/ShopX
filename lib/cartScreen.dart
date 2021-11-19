//import 'dart:html';
import 'dart:ui';

import 'package:ecommerce/Provider.dart';
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
    print("BUILDED");
    return Scaffold(
      // appBar: AppBar(
      //  backgroundColor: Colors.deepPurple,
      //  ),
      body: FutureBuilder(
          future: cartItems.getCartItems(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return cartItems.cartitems.length != 0
                  ? Column(
                      children: [
                        Container(
                          height: 50,
                        ),
                        Container(
                          height: 50,
                          child: Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Subtotal:',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24),
                                )),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "\$" +
                                      '${cartItems.cartTotal.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ))
                          ]),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 15),
                          child: ElevatedButton(
                            child: Text(
                              "Proceed to Buy (${cartItems.cartItems.length} items)",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            onPressed: null,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber)),
                          ),
                        ),
                        Container(height: 4, color: Colors.grey[200]),
                        // Container(
                        // height: 15,
                        // ),
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
                                    children: [
                                      Container(
                                          height: 150,
                                          margin: EdgeInsets.all(5),
                                          //  color: Colors.deepOrange,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // color: Colors.amber,
                                                margin: EdgeInsets.only(
                                                  bottom: 50,
                                                  top: 1,
                                                ),
                                                width: 130,
                                                height: 150,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Image.network(cartItems
                                                      .cartitems[index]
                                                      .productClass
                                                      .imageUrl),
                                                ),
                                              ),
                                              Container(
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
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 17,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
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
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            height: 40,
                                                            child: ElevatedButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                                                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey),
                                                                    ))),
                                                                onPressed: () {
                                                                  
                                                                  cartItems
                                                                      .addcartItems(
                                                                          index);
                                                                },
                                                                child: Stack(
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                            Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .black,
                                                                    ))
                                                                  ],
                                                                )),
                                                          ),
                                                          Consumer<provider>(
                                                              builder: ((ctx,
                                                                  parent,
                                                                  child) {
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          1)),
                                                              width: 50,
                                                              height: 40,
                                                              child: Center(
                                                                  child: Text(
                                                                '${parent.cartitems[index].cartCounter}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              )),
                                                            );
                                                          })),
                                                          Container(
                                                            width: 60,
                                                            height: 40,
                                                            child: ElevatedButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                                                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey),
                                                                    ))),
                                                                onPressed: () {
                                                                  cartItems
                                                                      .removecartItems(
                                                                          index);
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: 2,
                                        color: Colors.grey[200],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 8,
                        //   color: Colors.black,
                        // )
                      ],
                    )
                  : Container(
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            margin:
                                EdgeInsets.only(top: 10, left: 30, right: 30),
                            child: Text(
                              'Looks like you haven\'t added anything in your cart yet',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                          )
                        ],
                      ),
                    );
            else
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
          }),
    );
  }
}
