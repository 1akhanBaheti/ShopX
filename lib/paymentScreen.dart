import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/checkoutProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  //const PaymentScreen({Key? key}) : super(key: key);
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var payOnDelivery = false;

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<provider>(context, listen: true);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Container(
            child: Text(
              'Payment',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        body: Container(
          // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 2),
          child: Column(
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
                    child: SvgPicture.asset('assets/images/Payment.svg')),
              ),
              Container(
                height: 10,
                color: Colors.grey.shade200,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Text(
                        'Suggested for you',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300)),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              child: Checkbox(
                                value: payOnDelivery,
                                onChanged: (e) {
                                  setState(() {
                                    payOnDelivery = !payOnDelivery;
                                  });
                                },
                                checkColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                activeColor: Colors.deepPurple,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Pay on delivery',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                height: 10,
                color: Colors.grey.shade200,
              ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Price(${cartItems.cartitems.length} item)',
                            style: TextStyle(color: Colors.black, fontSize: 18))
                      ])),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Text(
                        '\$${cartItems.cartTotal}',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Delivery Charges',
                            style: TextStyle(color: Colors.black, fontSize: 18))
                      ])),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Text(
                        'FREE',
                        style: TextStyle(
                            color: Colors.green.shade800, fontSize: 18),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        '\$${cartItems.cartTotal}',
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
              Spacer(),
              InkWell(
                onTap: () async {
                  if (payOnDelivery) {
                    await checkoutProvider
                        .addOrder(checkoutProvider.checkoutItems)
                        .then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'toConfirmation', (route) => false);
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${e.message}')));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Please Choose Any Payment Method')));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                  ),
                  height: 50,
                  // margin: EdgeInsets.only(left: 20, right: 20,),
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
        ));
  }
}
