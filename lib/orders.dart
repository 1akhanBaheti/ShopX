import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/checkoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      //drawer: Drawer1(context),
      body: Container(
          child: FutureBuilder(
              future: checkoutProvider.getOrders(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Container(
                    decoration: BoxDecoration(
                        border: BorderDirectional(
                            top: BorderSide(color: Colors.grey.shade300))),
                    child: ListView.builder(
                        itemCount: checkoutProvider.orders.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Container(
                            //margin: EdgeInsets.all(2),
                            //  decoration:  BoxDecoration(border: Border.all(color: Colors.amber)),
                            height: 120,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    'toOrderDetailsScreenBeforeDelivery',
                                    arguments: checkoutProvider.orders[index]);
                              },
                              child: Card(
                                elevation: 0,
                                //  elevation: 15,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          Container(
                                            // decoration:  BoxDecoration(border: Border.all(color: Colors.amber)),
                                            // color: Colors.amber,
                                            margin: EdgeInsets.all(10),
                                            height: 80,
                                            width: 120,

                                            child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: CachedNetworkImage(
                                                    imageUrl: checkoutProvider
                                                        .orders[index]
                                                        .products[0]
                                                        .productClass
                                                        .imageUrl)),
                                          ),
                                          Container(
                                              //margin: EdgeInsets.only(left:15,right: 15),
                                              height: 150,
                                              width: 140,
                                              color: Colors.black
                                                  .withOpacity(0.035))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              //   color: Colors.deepPurple,
                                              // width: MediaQuery.of(context).size.width -
                                              //     150,
                                              padding: EdgeInsets.only(
                                                  top: 15, left: 10, right: 4),
                                              child: Text(
                                                 checkoutProvider.orders[index].products.length>1?
                                                "${checkoutProvider.orders[index].products[0].productClass.title} and ${checkoutProvider.orders[index].products.length-1} others":checkoutProvider.orders[index].products[0].productClass.title,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(height: 10),
                                          Container(
                                              //   color: Colors.deepPurple,
                                              // width: MediaQuery.of(context).size.width -
                                              //     150,
                                              padding: EdgeInsets.only(
                                                  top: 1, left: 10, right: 4),
                                              child: Text(
                                                'Ordered on ${checkoutProvider.orders[index].Date}',
                                                style: GoogleFonts.lato(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )),
                                          SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );

                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                  strokeWidth: 2,
                ));
              })),
    );
  }
}
