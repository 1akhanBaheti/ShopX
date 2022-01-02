
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
 // const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                       itemBuilder:((ctx,index){
                         return Container(
                           margin: EdgeInsets.all(2),
                         //  decoration:  BoxDecoration(border: Border.all(color: Colors.amber)),
                           height:180,
                           child: 
                          InkWell (
                            onTap: (){
                              Navigator.of(context).pushNamed('toProductDetaiLscreen',arguments: []);
                            },
                             child:
                           Card(
                                                   //  elevation: 15,
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children:[ 
                                   
                                   Container(
                                   
                                     child:
                                     Stack(
                                       children:[ 
                           
                                         Container(
                                          // decoration:  BoxDecoration(border: Border.all(color: Colors.amber)),
                                          // color: Colors.amber,
                                           margin: EdgeInsets.all(20),
                                           height: 180,
                                           width: 120,
                                           
                                           child: FittedBox(
                                           fit: BoxFit.fill,
                                               child:Image.network(Product[index]['image'] as String),
                                         
                                             ),
                                         ),
                                         Container(
                                           margin: EdgeInsets.all(2),
                                          height: 180,
                                          width: 160 ,
                                         
                                           color:Colors.black.withOpacity(0.035)
                                         )
                                                                   
                                                                    ],
                                     ),
                                   ),
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children:[
                           
                                   Container(
                                  //   color: Colors.deepPurple,
                                  width: MediaQuery.of(context).size.width - 188,
                                     margin: EdgeInsets.only(left:10,),
                                     child: Text(
                                       Product[index]['title'] as String,maxLines:3,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                     ),
                                     SizedBox(
                                     height:20
                                     ),
                                     Container(
                                       margin: EdgeInsets.only(left:10,),
                                       child: Text("\$" +
                                         Product[index]['price'].toString(),
                                         style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.red[900]),
                           
                                       ),
                                     )
                                     ],
                                   ),
                                 
                                 ],
                               ),
                           ),
                           ),
                         );
                       }),
                       itemCount: Product.length,
                       ),
                   
             
    );
  }
}