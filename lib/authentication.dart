
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Auth extends ChangeNotifier {
  var mainUser;
  Future getUser() async {
    var user = FirebaseAuth.instance.currentUser;

    print(user!.email);
  }

  // ignore: non_constant_identifier_names
  Future Signup(String email, String password, String name) async {
   // var auth = FirebaseAuth.instance;
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
            'checkoutItems':[],
            'cart': [],
            'saveForLater': [],
            'orders':{},
            "address":[]
          })
          .then((value) => null)
          .catchError((e) {});
    }).catchError((e) {
      throw (e);
    });

    return user;
  }

  Future checkEmailExist(String email) async {
    try {
      var check;
      await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email)
          .then((value) {
        check = value.isEmpty;
      });
      print(check);

      return check;
    } catch (er) {
      throw (er);
    }
  }

  Future signIn(String email, String password) async {
    var user;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        user = value.user;
      });
      return user;
    } catch (e) {
      print(e);
      throw (e);
    }
    
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
