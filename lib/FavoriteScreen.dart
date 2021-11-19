import 'package:ecommerce/Provider.dart';
import 'package:ecommerce/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  // const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favourite1 = Provider.of<provider>(context);
    var favourite = favourite1.favouriteItems;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurple,
      //   title: Text('Favourites'),
      // ),
      body: Column(
        children: [
          Container(
            
            //width:MediaQuery.of(context).size.width,
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+8),
            height: 50,
             //color: Colors.amber,
            child: Row(
              children: [
                // IconButton(
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                  //  icon: Icon(Icons.arrow_back,color: Colors.black,)),

                    Container(
                     // width: MediaQuery.of(context).size.width-48,
                     width:MediaQuery.of(context).size.width,
                    // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children:[ 
                          Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.only(left: 11),child: Text('Wishlist',style: GoogleFonts.lato(fontSize: 18,color: Colors.black,fontWeight:FontWeight.bold)),),
                              Container(margin: EdgeInsets.only(left: 11),child: Text('${favourite1.favouriteItems.length} items',style: GoogleFonts.lato(color: Colors.grey),))
                            ],
                          )
                        ),

                        Container(
                          //color: Colors.amber,
                          child: Center(child: IconButton(onPressed: null, icon: Icon(Icons.shopping_bag_outlined,color:Colors.black))))
                        ],
                      ),
                    ),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: favourite.length,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                      'toProductDetailScreen',
                      arguments: ProductClass(
                          category:favourite[index].category,
                          id: favourite[index].id,
                          price: favourite[index].price,
                          title: favourite[index].title,
                          imageUrl: favourite[index].imageUrl),
                    ),
                    child: Container(
                      decoration: BoxDecoration(

                          // border: Border(
                          //   bottom: BorderSide(
                          //     color: Colors.black,
                          //     width: 2
                          //   )
                          // )

                          ),
                      // height: 200,
                      // color: Colors.deepPurple,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              favourite[index].imageUrl),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        width: 210,
                                        color: Colors.grey.withOpacity(0.2),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7),
                                  child: Text(
                                    favourite[index].title,
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
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4 -
                                                30,
                                            margin: EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              Product[index]['category']
                                                  as String,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                //fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 7),
                                          child: Text(
                                            "\$" +
                                                favourite[index]
                                                    .price
                                                    .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: IconButton(
                                          onPressed: () {
                                            favourite1.removeFromFavourite(
                                                favourite[index]);
                                          },
                                          icon: Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    favourite1.addToCart(favourite[index], '1');
                                    favourite1
                                        .removeFromFavourite(favourite[index]);
                                    favourite[index].isFavourite = false;
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade300)),
                                    child: Center(
                                        child: Text(
                                      'MOVE TO BAG',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold),
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

      //Center(child: Text("${favourite.favouriteItems.length}"),),
    );
  }
}
