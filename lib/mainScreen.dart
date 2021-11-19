import 'dart:io';
import 'package:ecommerce/try.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/Componenets/Drawer.dart';
import 'package:ecommerce/cartScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:shimmer/shimmer.dart';

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
  var Fragments = [
    Favourite(),
    Favourite(),
    CartScreen(),
    trial(),
  ];

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    print('rendered');
    var current = Provider.of<provider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        // color: Colors.amber,

        child: GestureDetector(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  print(index);
                  current.index = index;
                });
              },
              currentIndex: current.index,
              elevation: 30,
              backgroundColor: Colors.white,
              fixedColor: Colors.deepPurple,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Wishlist'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),
                  label: 'Account',
                ),
              ],
            ),

           
            body: current.index == 0
                ? home(context, current)
                : Fragments[current.index],

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
  // FirebaseDatabase.instance.reference().child('Products');

  //var fireprov =Provider.of<>(context);
  @override
  void initState() {
    searchF = FocusNode();
    // firebaseDatabase = FirebaseDatabase.instance.reference();
    // firebaseDatabase.

    // _productCollection = _firebaseDatabase.ch
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
      drawer: Drawer1(widget.he),

      // appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    print('TAPPED');
                    // if (!Scaffold.of(context).isDrawerOpen) {
                    Scaffold.of(context).openDrawer();
                    // }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      top: MediaQuery.of(context).padding.top,
                    ),
                    //  color: Colors.amber,
                    height: 60,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 22,
                        // maxRadius: 30,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                );
              }),
              /////////////////////////////TEXTFORM FIELD//////////////////////////////////
              // Container(
              //   width: MediaQuery.of(context).size.width - 80,
              //   margin: EdgeInsets.only(
              //       left: 10,
              //       right: 10,
              //       top: MediaQuery.of(context).padding.top + 10,
              //       bottom: 10),
              //   child: TextFormField(
              //     //  autofocus: true,
              //     // focusNode: searchF,
              //     //  strutStyle: StrutStyle.disabled,
              //     controller: search,
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Colors.black,
              //       ),
              //       // icon: Icon(Icons.search),
              //       fillColor: Colors.white,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         borderSide: BorderSide(width: 1, color: Colors.grey),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         borderSide: BorderSide(width: 2, color: Colors.grey),
              //       ),

              //       focusColor: Colors.indigo,

              //       //enabled: true,
              //     ),
              //     cursorColor: Colors.purple,
              //     //autofocus: true,

              //     onEditingComplete: () {
              //       FocusScope.of(context).unfocus();
              //     },
              //   ),
              // ),
              ////////////////////////////////////////////////////////////////
              Container(
                height: 60,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                // color: Colors.amber,
                child: Row(children: [
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(widget.he)
                          .pushNamed('toSearch', arguments: widget.current);
                    },
                  )),
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black,
                    ),
                    onPressed: null,
                  )),
                  Container(
                      child: IconButton(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                    onPressed: null,
                  )),
                ]),
              )
            ]),

            //  Container(
            //    margin: EdgeInsets.only(left:2),
            //    child: Text('SHOP by category',style: GoogleFonts.lato(
            //      fontWeight: FontWeight.bold,
            //      fontSize: 16
            //    ),),
            //  ),
            SizedBox(height: 4),
            Container(
              // padding: EdgeInsets.only(top: 5,bottom: 5),
              //  width: 300,
              //color: Colors.grey.shade400,
              height: 90,

              child: GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, mainAxisSpacing: 10),
                itemBuilder: ((ctx, index) {
                  // return Container(
                  //   color: colors[0],
                  //   child: Center(
                  //       child: Text('CATEGORIES',
                  //           style: TextStyle(fontWeight: FontWeight.bold))),
                  // );
                  return Categories(categories[index], [
                    colors[index].shade800,
                    colors[index].shade700,
                    colors[index].shade600,
                    colors[index].shade500,
                    colors[index].shade400
                  ]);
                }),
              ),
            ),
            //  ],
            //  ),
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
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              // color: Colors.amber,
                              decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(20)
                                  ),
                              height: 190,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                // padding: EdgeInsets.all(30),
                                child: FittedBox(
                                  //alignment: Alignment.center,
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
                                        // shape: RoundedRectangleBorder(),
                                        // size: Size.square(50),
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
            //SizedBox(height: 10),
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
                                // ProductClass(
                                //   category:Product[index]['id'] as String ,
                                //     id: Product[index]['id'] as int,
                                //     price: Product[index]['price'] as int,
                                //     title: Product[index]['title'] as String,
                                //     imageUrl:
                                //         Product[index]['image'] as String));
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 130,
                                          // color: Colors.deepPurple,
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
                                        margin:
                                            EdgeInsets.only(left: 4, right: 4),
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
                                        margin:
                                            EdgeInsets.only(left: 4, right: 4),
                                        child: Text(
                                          fireprov.Products[index].category,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            //fontSize: 14,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 10,
            ),

            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'POPULAR',
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
            Container(
              // color: Colors.pink,
              //height: 400,
              decoration: BoxDecoration(
                  //borderRadius:   BorderRadius.circular(20),
                  //  color: Colors.pink,
                  border: Border.all(
                color: Colors.transparent,
              )),
              margin: EdgeInsets.only(left: 20, right: 20),

              child: Card(
                color: Colors.transparent,
                elevation: 0,
                // shape:
                //     RoundedRectangleBorder(
                //      // borderRadius: BorderRadius.circular(20)
                //      side: BorderSide(
                //        width: 0.2,
                //        color: Colors.grey
                //      )
                //       ),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.current.popular.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0),
                    itemBuilder: ((ctx, index) {
                      return Container(
                        child: Card(
                          elevation: 0,
                          // color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              // borderRadius: BorderRadius.circular(20)
                              side: BorderSide(width: 0.3, color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: (MediaQuery.of(context).size.width -
                                            40) *
                                        0.5,
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(20),
                                        child: Image.network(widget
                                            .current.popular[index].imageUrl),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 4, right: 4),
                                  child: Text(
                                    widget.current.popular[index].title,
                                    style: GoogleFonts.ptSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 4, right: 4),
                                  child: Text(
                                    'category',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      //fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(height: 6),
                              Container(
                                  margin: EdgeInsets.only(left: 4),
                                  child: Text(
                                    widget.current.popular[index].price
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

                        ///      1         /////
                      );
                    })),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////////////////////////
//  Container(
//         child: Card(
//           elevation: 0,
//           // color: Colors.transparent,
//           shape: RoundedRectangleBorder(
//               // borderRadius: BorderRadius.circular(20)
//               side: BorderSide(width: 0.3, color: Colors.grey)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: 100,
//                     width: (MediaQuery.of(context).size.width - 40) * 0.5,
//                     margin: EdgeInsets.only(top: 10, bottom: 10),
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: ClipRRect(
//                         // borderRadius: BorderRadius.circular(20),
//                         child: Image.network(current.imageUrl),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                   margin: EdgeInsets.only(left: 4, right: 4),
//                   child: Text(
//                     current.title,
//                     style: GoogleFonts.ptSans(
//                       fontSize: 15,
//                       fontWeight: FontWeight.normal,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   )),
//               Container(
//                   margin: EdgeInsets.only(left: 4, right: 4),
//                   child: Text(
//                     'category',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       //fontSize: 14,
//                       fontWeight: FontWeight.normal,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   )),
//               SizedBox(height: 6),
//               Container(
//                   margin: EdgeInsets.only(left: 4),
//                   child: Text(
//                     current.price.toString(),
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ))
//             ],
//           ),
//         ),

//         ///      1         /////
//       ),
