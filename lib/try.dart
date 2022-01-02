import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/authentication.dart';
import 'package:ecommerce/signupScreens/mainOtions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/firebaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class trial extends StatelessWidget {
  //const try({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prod = [];
    var fire = Provider.of<FirebaseProvider>(context);

    var firebaseDatabase = FirebaseDatabase.instance;
    var auth = Provider.of<Auth>(context);
    
    return Shimmer.fromColors(
                      child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: ((ctx, index) {
                              return Container(
                           
                                height: 150,
   
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      top: 15,
                                                      left: 7,
                                                      right: 7),
                                              ),
                                              
                                              Container(
                                                width: 100,
                                                height: 20,
                                                   color: Colors.white,
                                                  margin: EdgeInsets.only(top: 10,
                                                    left: 7,
                                                    right: 7
                                                  ),
                                                  ),
                                            
                                              Container(
                                                width: 50,
                                                height: 20,
                                                margin: EdgeInsets.only(
                                                  top: 10,
                                                  left: 7,
                                                  right: 7
                                                ),
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
  }
}
