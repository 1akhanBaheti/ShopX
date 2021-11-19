
import 'package:ecommerce/products.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
 // const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
               children: [
                 Container(
                   margin: EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10),
        
                   child:
                TextFormField(
              //  strutStyle: StrutStyle.disabled,
                
                   decoration: InputDecoration(
                     fillColor: Colors.white,
                     border: OutlineInputBorder(

                       borderRadius:BorderRadius.circular(10),
                       borderSide: BorderSide(width: 10,color:Colors.grey),
                       
                     ),
                     disabledBorder:OutlineInputBorder(

                       borderRadius:BorderRadius.circular(10),
                       borderSide: BorderSide(color:Colors.grey),
                       
                     ) ,
                     focusColor: Colors.indigo,
                     
                     hoverColor: Colors.deepPurple,
                     //enabled: true,
                     focusedBorder: OutlineInputBorder(

                       borderRadius:BorderRadius.circular(10),
                       borderSide: BorderSide(width: 2,color:Colors.grey),
                       
                     )
                     
                   ),
                   cursorColor: Colors.purple,
                   //autofocus: true,
                   onTap: ()
                   {
                     FocusScope.of(context).requestFocus();                   },
                  onEditingComplete: (){
                    FocusScope.of(context).unfocus();
                  },
                ),
                 ),
                   Expanded(
                     child: ListView.builder(
                      
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
                   ),
               ],
               
             ),
    );
  }
}