import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Provider.dart';
import 'dart:convert';
import 'package:ecommerce/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirebaseProvider extends ChangeNotifier {
  var firebaseApp;
  // late User UserDetails;
  bool loadMainOnce = false;
  List<ProductClass> Products = [];
  List<ProductClass> SearchProducts = [];
  firest() async {
    // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    var inst = [];
    //FirebaseFirestore firestore =
    // FirebaseFirestore.instanceFor(app: secondaryApp);
    Firebase.initializeApp();

    await FirebaseFirestore.instance.collection('Products').get().then((value) {
      value.docs.forEach((element) {
        inst.add(element.data());
      });
    });

    return inst;
  }

  Future getProducts() async {
    if (!loadMainOnce) {
      print("RAN");
      List<ProductClass> loca = [];
      var url = Uri.parse(
          'https://adminpanel-23c73-default-rtdb.asia-southeast1.firebasedatabase.app/Products.json');

      var response = await http.get(url);
      var data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((id, data) {
        loca.add(ProductClass(
            description: data['description'],
            category: data['category'],
            id: data['id'],
            price: data['price'],
            title: data['title'],
            imageUrl: data['image']));
      });
      Products = loca;
      loadMainOnce = true;
      return data;
    }

    return Products;
  }
//////////////////////////SEARCH IMPLEMENTATION ///////////////////////////////////////

  void searchItems(String s) {
    if (s.length == 0) {
      SearchProducts = [];
      notifyListeners();
      return;
    }
    SearchProducts = [];
    Products.forEach((element) {
      if (element.title.toLowerCase().startsWith(s.toLowerCase()) ||
          element.title.toLowerCase().contains(s.toLowerCase())) {
        SearchProducts.add(element);

        notifyListeners();
      }
    });
  }

///////////////////////////////////////////////////////////////////////////////////////
}
