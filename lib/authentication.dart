import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/expect.dart';

class Auth extends ChangeNotifier {
  var mainUser;
  Future getUser() async {
    var user = FirebaseAuth.instance.currentUser;

    print(user!.email);
  }

  Future Signup(String email, String password, String name) async {
    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    var user;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      user = value.user;
      await value.user!.updateDisplayName(name);
      await firestore
          .collection('Users')
          .doc(value.user!.uid)
          .set({
            'uid': value.user!.uid,
            'email': value.user!.email,
            'mobile no.': null,
            'name': name,
            'wishlist': [],
            'cart': [{}],
          })
          .then((value) => null)
          .catchError((e) {});
    }).catchError((e) {
      throw (e);
    });

    return user;
  }

  Future checkEmailExist(String email) async {
    var method = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (method.isEmpty) return false;

    return true;
  }

  Future signIn(String email, String password) async {
    var user;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      user = value.user;
    }).catchError((e) {
      print(e);
      throw (e);
    });
    return user;
  }

  Future logOut() async {
    var signout = false;
    await FirebaseAuth.instance
        .signOut()
        .then((value) => signout = true)
        .catchError((e) {
      throw (e);
    });
    return signout;
  }
}
