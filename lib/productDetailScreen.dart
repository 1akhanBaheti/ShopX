import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/CLASScart.dart';
import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/checkoutProvider.dart';
import 'package:ecommerce/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  //const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var _qty = "1";
  var isLoading = false;
  var favouriteLoading = false;
  var categorySelected = 0;
  @override
  Widget build(BuildContext context) {
  //  print('llllllk');
    // var categorySelector = false;
    var data = ModalRoute.of(context)!.settings.arguments as ProductClass;
    var vider = Provider.of<provider>(context, listen: true);
    var checkoutProvider = Provider.of<CheckoutProvider>(context);

    // ignore: unused_element
    bool check(ProductClass p) {
      bool is1 = false;
      vider.favouriteItems.forEach((element) {
        if (element.id == p.id) {
          is1 = true;
        }
      });
      if (is1) return true;

      return false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              //margin: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 1, color: Colors.grey.shade300),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(data.title,
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                //  fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              CarouselSlider.builder(
                                  itemCount: 1,
                                  itemBuilder: ((ctx, index, p) {
                                    return Container(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 400,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child:
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                    data.imageUrl),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  options: CarouselOptions(
                                      height: 400,
                                      enableInfiniteScroll: false)),
                              Container(
                                height: 50,
                                alignment: Alignment.topRight,
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width,
                                child: vider.isFavourite(data)
                                    ? IconButton(
                                        onPressed: () async {
                                          await vider
                                              .removeFromFavourite(data)
                                              .then((value) {})
                                              .catchError((e) {
                                            print(e.message);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          await vider
                                              .addToFavourite(data)
                                              .then((value) {})
                                              .catchError((e) {
                                            print(e.message);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.favorite_outline_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: DotsIndicator(
                              decorator:
                                  DotsDecorator(activeColor: Colors.deepPurple),
                              dotsCount: 3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    height: 8,
                  ),
                  Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "₹${data.packaging[categorySelected]['price']}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            'inclusive of all taxes',
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text(
                            'Category:',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        //SizedBox(height:20),
                        /////////////////////////////////////////////////////////////////////////////////
                        Container(
                          //  height: 60,
                          margin: EdgeInsets.only(left: 10),
                          child: GridView.builder(
                              // scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.packaging.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 3,
                                      childAspectRatio: 5 / 3,
                                      crossAxisCount: 4),
                              shrinkWrap: true,
                              itemBuilder: ((ctx, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        categorySelected = index;
                                      });
                                    },
                                    child: categorySelected == index
                                        ? Container(
                                            child: Card(
                                                color: Colors.grey.shade300,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade200,
                                                    )),
                                                elevation: 2,
                                                child: Center(
                                                    child: Text(
                                                        '${data.packaging[index]['qty']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)))),
                                          )
                                        : Container(
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade200,
                                                    )),
                                                elevation: 2,
                                                child: Center(
                                                    child: Text(
                                                        '${data.packaging[index]['qty']}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)))),
                                          ));
                              })),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                'Qty:',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 100,
                              child: Card(
                                borderOnForeground: true,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    side: BorderSide(
                                        width: 1, color: Colors.grey)),
                                //elevation: 20,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurple,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _qty = value!;
                                        print(_qty);
                                      });
                                    },
                                    value: _qty,
                                    items: [
                                      DropdownMenuItem(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        value: "1",
                                      ),
                                      DropdownMenuItem(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '2',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        value: "2",
                                      ),
                                      DropdownMenuItem(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '3',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        value: "3",
                                      ),
                                      DropdownMenuItem(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '4',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        value: "4",
                                      ),
                                      DropdownMenuItem(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '5',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        value: "5",
                                      ),
                                      DropdownMenuItem(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '6',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        value: "6",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 60,
                            //color: Colors.yellow,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                left: 30, right: 30, top: 15, bottom: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.yellow),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                              onPressed: () async {
                                if (FirebaseAuth.instance.currentUser == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please Log in First!')));
                                } else {
                                  var item = ProductClass(
                                    packaging: data.packaging,
                                    description: data.description,
                                    category: data.category,
                                    id: data.id,
                                    price: data.price,
                                    title: data.title,
                                    imageUrl: data.imageUrl,
                                  );

                                  // var is1 = vider.addToCart(item, _qty);

                                  var found = false;

                                  vider.cartitems.forEach((element) {
                                    if (element.productClass.id == item.id)
                                      found = true;
                                  });

                                  if (found) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 1),
                                            content: Container(
                                              child: Text(
                                                  'Already in your Cart',
                                                  style: GoogleFonts.lato()),
                                            )));
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await vider
                                        .addCartItems(
                                          Cart(
                                            packagingIndex:categorySelected,
                                            cartCounter: int.parse(_qty),
                                            productClass: item))
                                        .then((value) {
                                      print(value);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              duration: Duration(seconds: 1),
                                              content: Container(
                                                child: Text('Added to Cart',
                                                    style: GoogleFonts.lato()),
                                              )));
                                    });
                                  }
                                }
                              },
                              child: Text(
                                'Add To Cart',
                                style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.amber),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                              onPressed: () {
                               

                                if (FirebaseAuth.instance.currentUser == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please Log in First!')));
                                }
                                else{
                                   setState(() {
                                  isLoading = true;
                                });
                                   checkoutProvider.updateCheckoutItems([
                                  {
                                    'id': data.id,
                                    "category": data.category,
                                    "price": data.price,
                                    "title": data.title,
                                    "imageUrl": data.imageUrl,
                                    "description": data.description,
                                    'cartCounter': int.parse(_qty)
                                  }
                                ]).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context)
                                      .pushNamed('toCheckoutScreen');
                                });
                                }
                               
                              },
                              child: Text('Buy Now',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    height: 8,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Details:',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        '${data.description.replaceAll((','), '.').replaceAll('.', '.\n\n')}',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        ),
                      )),
                  // Container(
                  //     margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  //     child: Text(
                  //       'DESCRIPTION',
                  //       style: GoogleFonts.lato(fontSize: 18),
                  //     )),
                  Container(
                    color: Colors.grey[300],
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white.withOpacity(0.3),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.deepPurple,
                    ),
                  ),
                )
              : Container(),
          favouriteLoading
              ? Container(
                  color: Colors.white.withOpacity(0.6),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
