import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:ecommerce/CLASScart.dart';
import 'package:ecommerce/adressDataModel.dart';
import 'package:ecommerce/orderDataModel.dart';
import 'package:ecommerce/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  var address = [];
  List<ORDER> orders = [];
  List<Cart> checkoutItems = [];
  var checkoutTotal = 0;
  var particularAdress;
  var cartItems;
  var temp = [];

  Future updateCheckoutItems(List temp1) async {
    var checkoutTemp = temp1;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'checkoutItems': checkoutTemp});
    } catch (e) {
      throw (e);
    }
  }

  Future getCheckoutItems() async {
    var temp1 = [];
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        checkoutItems = [];
        temp1 = await value.data()!['checkoutItems'];
        temp = temp1;
        checkoutTotal = 0;
        temp1.forEach((element) {
          checkoutItems.add(Cart(
              cartCounter: element['cartCounter'],
              productClass: ProductClass(
                  id: element['id'],
                  category: element['category'],
                  price: element['price'],
                  title: element['title'],
                  imageUrl: element['imageUrl'],
                  description: element['description'])));
        });
        checkoutItems.forEach((element) {
          checkoutTotal += element.productClass.price * element.cartCounter;
        });
      });
      print(checkoutItems.length);
    } catch (e) {
      throw (e);
    }
  }

  Future getaddress() async {
    try {
       await getCheckoutItems();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
      //  print(value.data()!['address']);

        // print(value.data());

        address = await value.data()!['address'];

        if (particularAdress == null) particularAdress = address[0];
      });
      //return data;
    } catch (e) {
      throw (e);
    }

    // print(data['id']);
  }

  void updateParticularAddress(var address1) {
    particularAdress = address1;
    notifyListeners();
  }

  Future addOrder(List<Cart> c) async {
    var temp = [];
    var orders = [];

    var cartGroup = [];

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      cartGroup = value.data()!['cart'];
    });

    c.forEach((element) {
      var t = {
        'Product': {
          'category': element.productClass.category,
          'id': element.productClass.id,
          'imageUrl': element.productClass.imageUrl,
          'isFavourite': element.productClass.isFavourite,
          'price': element.productClass.price,
          'title': element.productClass.title,
          'description': element.productClass.description
        },
        'cartCounter': element.cartCounter,
        'totalPrice': element.productClass.price * element.cartCounter,
        'address': particularAdress,
        'productGroup': cartGroup,
        'paymentgateway': 'Cash On Delivery',
      };
      temp.add(t);
    });
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        orders = value.data()!['orders'];
        orders.addAll(temp);
        try {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'orders': orders,
            'cart': [],
          });
        } catch (e) {
          throw (e);
        }
      });
    } catch (e) {
      throw (e);
    }
  }

  Future getOrders() async {
    var temp1 = [];
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        temp1 = value.data()!['orders'];

        orders = [];
        temp1.forEach((element) {
          orders.add(ORDER(
              product: ProductClass(
                  description: element['Product']['description'],
                  id: element['Product']['id'],
                  category: element['Product']['category'],
                  price: element['Product']['price'],
                  title: element['Product']['title'],
                  imageUrl: element['Product']['imageUrl']),
              address: ADDRESS(
                  Fullname: element['address']['Fullname'],
                  Mobilenumber: element['address']['Mobilenumber'],
                  AreaColonyStreetSectorVillage: element['address']
                      ['Area,Colony,Street,Sector,Village'],
                  FlatHousenoBuildingCompanyApartment: element['address']
                      ['Flat,House no,Building,Company,Apartment'],
                  Landmark: element['address']['Landmark'],
                  Country: element['address']['Country'],
                  State: element['address']['State'],
                  City: element['address']['City'],
                  Pincode: element['address']['Pincode']),
              cartCounter: element['cartCounter'],
              totalPrice: element['totalPrice'],
              paymentGateway: element['paymentgateway']));
        });
        return orders;
      });
    } catch (e) {
      throw (e);
    }
  }

  Future updateQty(int index, int value) async {
    temp[index]['cartCounter'] = value;
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'checkoutItems': temp}).then((value) {});
      return notifyListeners();
    } catch (e) {
      throw (e);
    }
  }
}
