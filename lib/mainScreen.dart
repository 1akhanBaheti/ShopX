import 'dart:io';
import 'package:ecommerce/productsListScreen.dart';
import 'package:ecommerce/try.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/Componenets/Drawer.dart';
import 'package:ecommerce/cartScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/expect.dart';

import './Componenets/category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/Account.dart';
import 'package:ecommerce/DeliveryAdress_base_Screen.dart';
import 'package:ecommerce/FavoriteScreen.dart';
import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebaseProvider.dart';

class Mainscreen extends StatefulWidget {
//  const Mainscreen({Key? key}) : super(key: key);
  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  var colors = [
    Colors.amber,
    Colors.deepPurple,
    Colors.red,
    Colors.green,
    Colors.brown,
  ];
  var bottomIndex = 0;

  // var random = new Random();

  @override
  Widget build(BuildContext context) {
    var Fragments = [
      // Favourite(context),
      //Favourite(context),
      CartScreen(),
      Account()
    ];
    // print(MediaQuery.of(context).size.width);
    print('rendered');
    var current = Provider.of<provider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        // color: Colors.amber,

        child: GestureDetector(
          child: Scaffold(
              drawer: Drawer1(context),
              appBar: AppBar(
                actions: [
                  Container(
                    child: Row(children: [
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            'toSearch',
                          );
                        },
                      )),
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('toNotificationScreen');
                        },
                      )),
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.favorite_outline,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('toFavouriteScreen');
                        },
                      )),
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('toCartScreen');
                        },
                      )),
                    ]),
                  )
                ],

                //automaticallyImplyLeading: true,
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0,
              ),
              resizeToAvoidBottomInset: false,
              body: home(context, current)
              // : Fragments[current.index],

              // bottomIndex == 0 ? home(context) : Fragments[bottomIndex],
              ),
        ),
      ),
    );
  }
}

class home extends StatefulWidget {
  // const home({Key? key}) : super(key: key);
  var he;
  var current;

  home(this.he, this.current);

  @override
  State<home> createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  var searchF;
  var firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    searchF = FocusNode();

    super.initState();
  }

  var banner = [
    'pexels-artem-beliaikin-2292953.jpg',
    'diwali-festival-sale-poster-design_1017-15674.jpg',
    'gradient-colorful-sale-wallpaper_52683-55788.jpg',
    'super-sale-banner-design-vector-illustration_1035-14931.jpg',
  ];
  //firebaseDatabase.o
  var search = TextEditingController();
  var isDrawer = false;
  var colors = [
    Colors.amber,
    Colors.deepPurple,
    Colors.red,
    Colors.green,
    Colors.brown,
  ];
  var categories = [
    'Mobiles',
    'Electronics',
    'Essentials',
    'Fashion',
    'Home',
  ];

  var bottomIndex;

  // var random = new Random();

  @override
  Widget build(BuildContext context) {
    print('RENDERED!');

    var fireprov = Provider.of<FirebaseProvider>(context);

    return Scaffold(
      //drawer: Drawer1(widget.he),

      // appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            var focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus) {
              focus.unfocus();
            }
          },
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),

              SizedBox(
                height: 4,
              ),
              CarouselSlider.builder(
                itemCount: banner.length,
                itemBuilder: ((ctx, index, no) {
                  return Container(
                    //  color: colors[random.nextInt(5)],
                    //  height: 300,
                    width: MediaQuery.of(context).size.width - 0,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(),
                                height: 190,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: SizedBox(
                                      width: 100,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/${banner[index]}')),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          child: Center(
                            child: Consumer<provider>(
                                builder: (context, parent, child) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  child: DotsIndicator(
                                      mainAxisSize: MainAxisSize.max,
                                      decorator: DotsDecorator(
                                          activeColor: Colors.deepPurple,
                                          color: Colors.grey.shade400),
                                      position: parent.current.toDouble(),
                                      dotsCount: 3),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                options: CarouselOptions(
                  onPageChanged: (index, a) {
                    widget.current.increment();

                    print(index);
                  },
                  height: 190,
                  viewportFraction: 1,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Top Rated',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal, fontSize: 20),
                  )),

              Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 210,
                  child: FutureBuilder(
                      future: fireprov.getProducts(),
                      builder: ((ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done)
                          return GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 3,
                                    childAspectRatio: 4 / 3),
                            itemBuilder: ((ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(widget.he).pushNamed(
                                      'toProductDetailScreen',
                                      arguments: fireprov.Products[index]);
                                },
                                child: Card(
                                  elevation: 0,
                                  // color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 0.2, color: Colors.grey)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 130,
                                            margin: EdgeInsets.all(10),
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(fireprov
                                                    .Products[index].imageUrl),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Text(
                                            fireprov.Products[index].title,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Text(
                                            fireprov.Products[index].category,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      SizedBox(height: 6),
                                      Container(
                                          margin: EdgeInsets.only(left: 4),
                                          child: Text(
                                            "\$" +
                                                fireprov.Products[index].price
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                            itemCount: fireprov.Products.length,

                            // shrinkWrap: true
                          );
                        else
                          return Shimmer.fromColors(
                            enabled: true,
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade200,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 3,
                                      childAspectRatio: 4 / 3),
                              itemBuilder: ((ctx, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        //width: 130,
                                        color: Colors.white,
                                        padding: EdgeInsets.only(right: 10),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                        top: 5,
                                      )),
                                      Container(
                                        color: Colors.white,
                                        height: 25,
                                        //padding: EdgeInsets.only(left: 4, right: 4, top: 10),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 4, right: 4)),
                                      Container(
                                        width: 80,
                                        color: Colors.white,
                                        height: 17,
                                        // padding: EdgeInsets.only(left: 4, right: 4, top: 5),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 4, right: 4)),
                                      Container(
                                        width: 45,
                                        color: Colors.white,
                                        height: 17,
                                        // margin: EdgeInsets.only(left: 4, top: 5,right: 4),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              itemCount: 5,
                              // shrinkWrap: true
                            ),
                          );
                      }))),

              // ],
              //   ),

              SizedBox(
                height: 20,
              ),

              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'Explore all',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal, fontSize: 20),
                  )),

              //  SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(widget.he).pushNamed('toPopularScreen');
                },
                child: Container(
                  // color: Colors.amber,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width - 70),
                  child: Text(
                    'see all',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ),
//////////////////////////////////////////////////////////////////////////////////
              FutureBuilder(
                  future: fireprov.getProducts(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: ((ctx, index) {
                              return Container(
                                //margin: EdgeInsets.all(2),
                                //  decoration:  BoxDecoration(border: Border.all(color: Colors.amber)),
                                height: 150,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(widget.he).pushNamed(
                                        'toProductDetailScreen',
                                        arguments: fireprov.Products[index]);
                                  },
                                  child: Card(
                                    elevation: 0,
                                    //  elevation: 15,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Stack(
                                            children: [
                                              Container(
                                                // decoration:  BoxDecoration(border: Border.all(color: Colors.amber)),
                                                // color: Colors.amber,
                                                margin: EdgeInsets.all(10),
                                                height: 130,
                                                width: 120,

                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Image.network(
                                                      Product[index]['image']
                                                          as String),
                                                ),
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
                                                      top: 15,
                                                      left: 10,
                                                      right: 4),
                                                  child: Text(
                                                    Product[index]['title']
                                                        as String,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )),
                                              SizedBox(height: 4),
                                              Container(
                                                  //   color: Colors.deepPurple,
                                                  // width: MediaQuery.of(context).size.width -
                                                  // 140,
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  child: Text(
                                                    Product[index]['category']
                                                        as String,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Text(
                                                  "\$" +
                                                      Product[index]['price']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red[900]),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            itemCount: fireprov.Products.length),
                      );
                    }

                    return Shimmer.fromColors(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: ((ctx, index) {
                              return Container(
                                height: 150,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 130,
                                      width: 140,
                                      color: Colors.white,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            color: Colors.white,
                                            margin: EdgeInsets.only(
                                                top: 15, left: 7, right: 7),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 20,
                                            color: Colors.white,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 7, right: 7),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 20,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 7, right: 7),
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            itemCount: 2),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100);
                  }),
            ],
          )),
        ),
      ),
    );
  }
}
