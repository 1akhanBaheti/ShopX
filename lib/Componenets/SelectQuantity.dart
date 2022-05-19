
import 'package:ecommerce/checkoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectQuantity extends StatefulWidget {
  // SelectQuantity({Key? key}) : super(key: key);
  var ctx, index, qty;
  SelectQuantity(this.ctx, this.index, this.qty);
  @override
  _SelectQuantityState createState() => _SelectQuantityState();
}

class _SelectQuantityState extends State<SelectQuantity> {
  @override
  Widget build(BuildContext context) {
    print('bbbbb');
    //var cartItems = Provider.of<provider>(context, listen: true);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: true);
    return Container(
        child: Wrap(children: [
      Container(
        //  height: 100,
        margin: EdgeInsets.only(top: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  //color: Colors.deepOrange,
                  // width: 150,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Select Quantity',
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(widget.ctx);
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      )),
                )
              ]),
              Container(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 8),
                        width: MediaQuery.of(context).size.width - 90,
                        child: GridView.builder(
                            itemCount: 6,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 6),
                            shrinkWrap: true,
                            itemBuilder: (context, index1) {
                              return widget.qty == index1 + 1
                                  //cartItems.cartitems[index].cartCounter == index1 + 1
                                  ? Container(
                                      child: Center(
                                          child: Text(
                                        '${index1 + 1}',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.deepPurple)),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          widget.qty = index1 + 1;
                                        });

                                        // await cartItems
                                        //     .increment(widget.index, index1 + 1)
                                        //     .then((value) {});

                                        // setState(() {});
                                        // cartItems.cartitems[index].cartCounter = index1 + 1;
                                      },
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          '${index1 + 1}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        )),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.black)),
                                      ),
                                    );
                            })),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: TextButton(
                          onPressed: null,
                          child: Text(
                            'more',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await checkoutProvider
                      .updateQty(widget.index, widget.qty)
                      .then((value) {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      //borderRadius:BorderRadius.circular(10)
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(
                      child: Text('Continue',
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
              )
            ]),
      ),
    ]));
  }
}
