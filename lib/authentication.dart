import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  var mainUser;
  Future getUser() async {
    var user = FirebaseAuth.instance.currentUser;

    print(user!.email);
  }

  Future Signup(String email, String password, String name) async {
    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;

    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
     User? mainUser = user.user;

      if (user.user != null) {
        print(user.user);

        await firestore.collection('Users').doc(user.user!.uid).set({
          'uid': user.user!.uid,
          'email': user.user!.email,
          'mobile no.': null,
          'name': name,
          'wishlist': [],
          'cart': [{}],
        }).then((value) => user.user);
      }
    } catch (e) {
      throw (e);
    }
  }
}
