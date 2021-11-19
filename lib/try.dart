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
    //auth.getUser();
    // var ref = firebaseDatabase.reference().child('Products');
   // FirebaseAuth.instance.signOut();
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .update({
    //   'CART': [{}],
    // });
    return Container();
  }
}
