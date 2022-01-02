import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  var he;

  @override
  Widget build(BuildContext context) {
    var favourite1 = Provider.of<provider>(context, listen: true);

    return Scaffold(
        body: Container(
      child: FutureBuilder(
        future: favourite1.getWishlistItems(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (favourite1.favouriteItems.length != 0) {
              print(snapshot.data);
              return Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    )),
                              ),
                              Container(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 11),
                                    child: Text('Wishlist',
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 11),
                                        child: Text(
                                          '${favourite1.favouriteItems.length} items',
                                          style: GoogleFonts.lato(
                                              color: Colors.black),
                                        )),
                                  )
                                ],
                              )),
                            ],
                          ),
                          Container(
                              //color: Colors.amber,
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('toCartScreen');
                                      },
                                      icon: Icon(Icons.shopping_bag_outlined,
                                          color: Colors.black))))
                        ],
                      ),
                    ),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          itemCount: favourite1.favouriteItems.length,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.of(context).pushNamed(
                                'toProductDetailScreen',
                                arguments: ProductClass(
                                    description: favourite1
                                        .favouriteItems[index].description,
                                    category: favourite1
                                        .favouriteItems[index].category,
                                    id: favourite1.favouriteItems[index].id,
                                    price:
                                        favourite1.favouriteItems[index].price,
                                    title:
                                        favourite1.favouriteItems[index].title,
                                    imageUrl: favourite1
                                        .favouriteItems[index].imageUrl),
                              ),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(20),
                                                  height: 190,
                                                  width: 200,
                                                  //color: Colors.amber,
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Image.network(
                                                          favourite1
                                                              .favouriteItems[
                                                                  index]
                                                              .imageUrl)),
                                                ),
                                                Container(
                                                  height: 200,
                                                  width: 210,
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 7),
                                            child: Text(
                                              favourite1
                                                  .favouriteItems[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.ptSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      // color: Colors.deepOrange,
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.4 -
                                                              30,
                                                      margin: EdgeInsets.only(
                                                          left: 4, right: 4),
                                                      child: Text(
                                                        favourite1
                                                            .favouriteItems[
                                                                index]
                                                            .category,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          //fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7),
                                                    child: Text(
                                                      "\$" +
                                                          favourite1
                                                              .favouriteItems[
                                                                  index]
                                                              .price
                                                              .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: IconButton(
                                                    onPressed: () {
                                                      favourite1
                                                          .removeFromFavourite(
                                                              favourite1
                                                                      .favouriteItems[
                                                                  index]);
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite_rounded,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await favourite1
                                                  .moveToBagFromFavourite(
                                                      index);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Center(
                                                  child: Text(
                                                'MOVE TO BAG',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else
              return Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    )),
                              ),
                              Container(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 11),
                                    child: Text('Wishlist',
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 11),
                                        child: Text(
                                          '${favourite1.favouriteItems.length} items',
                                          style: GoogleFonts.lato(
                                              color: Colors.black),
                                        )),
                                  )
                                ],
                              )),
                            ],
                          ),
                          Container(
                              //color: Colors.amber,
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('toCartScreen');
                                      },
                                      icon: Icon(Icons.shopping_bag_outlined,
                                          color: Colors.black))))
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 300,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child:
                              Image.asset('assets/images/EmptyWishlist.jpg')),
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Center(
                            child: Text(
                              'Save items that you like in your wishlist.\nReview them anytime and easily move them to bag.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontSize: 19, color: Colors.grey),
                            ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.teal.shade300)),
                              onPressed: () {},
                              child: Text(
                                'Continue Shopping',
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                ),
                              ))),
                    )
                  ],
                ),
              );
          }

          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 1.5,
            ),
          );
        },
      ),
    )

        //Center(child: Text("${favourite.favouriteItems.length}"),),
        );
  }
}
