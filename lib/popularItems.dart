import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/firebaseProvider.dart';
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class Popular extends StatelessWidget {
  //const Popular({Key? key}) : super(//key: key);

  @override
  Widget build(BuildContext context) {
    var fire =Provider.of<FirebaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Container(
        //color: Colors.white,
        margin: EdgeInsets.all(6),
        child: GridView.builder(
               
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 0, crossAxisSpacing: 0,childAspectRatio: 0.55),
            itemBuilder: ((ctx, index) {
              return InkWell(
                onTap: ()=>Navigator.of(context).pushNamed('toProductDetailScreen',arguments: ProductClass(
                        // packaging: Product[index]['packaging'] as List<Map<String,dynamic>>, 
                         description: Product[index]['description'] as String,
                         category: Product[index]['category'] as String,
                            id: Product[index]['id'] as int,
                            price: Product[index]['price'] as int,
                            title: Product[index]['title'] as String,
                            imageUrl: Product[index]['image'] as String)),
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
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: 
                    Stack(
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
                                child:
                                CachedNetworkImage(imageUrl: fire.Products[index].imageUrl)
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
                                child: Text(fire.Products[index].title,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.ptSans(fontWeight: FontWeight.w500,fontSize: 16),),
                              
                            ),
                           
                            SizedBox(height: 7,),

                             Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          child: Text(
                            fire.Products[index].category,
                            style: TextStyle(
                              color: Colors.grey,
                              //fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                            // Container(
                            //   margin: EdgeInsets.only(left: 7),
                            //   height: 25,
                            //   width: 50,
                            //  // color: Colors.green,
                            
                            //   child: Row(
                            //     children: [
                                 
                            //      Icon(
                            //        Icons.star_half_outlined
                            //        ,color: Colors.amber,
                            //      ),
                            //      Container(
                            //        margin :EdgeInsets.only(left:3),
                            //        child: Text("4.7",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black),)),
                            //     ],
                            //   ),
                            // ),
                             SizedBox(
                              height:7,
                            ),
                           
                             Container(
                              margin: EdgeInsets.only(left: 7),
                              child: Text("\$"+fire.Products[index].price.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
              
            }),
            itemCount: fire.Products.length,
            ),
      ),
    );
  }
}
