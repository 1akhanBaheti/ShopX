import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/CLASScart.dart';
import 'package:ecommerce/FirebaseCredentials.dart';
import 'package:ecommerce/adressDataModel.dart';
import 'package:ecommerce/orderDataModel.dart';
import 'package:ecommerce/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              packagingIndex: element['packagingIndex'],
              cartCounter: element['cartCounter'],
              productClass: ProductClass(
                  packaging: element['packaging'],
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
    Map<String, dynamic> orders = {};

    // await FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((value) {
    //   cartGroup = value.data()!['cart'];
    // });
    var totalPrice = 0;

    c.forEach((element) {
      totalPrice += (element.productClass.price * element.cartCounter);
      var t = {
        'Product': {
          'category': element.productClass.category,
          'id': element.productClass.id,
          'imageUrl': element.productClass.imageUrl,
          'isFavourite': element.productClass.isFavourite,
          'packaging': element.productClass.packaging,
          'price': element.productClass.price,
          'title': element.productClass.title,
          'description': element.productClass.description
        },
        'packagingIndex': element.packagingIndex,
        'cartCounter': element.cartCounter,
        'totalPrice': element.productClass.price * element.cartCounter,
        //'address': particularAdress,
        //'paymentgateway': 'Cash On Delivery',
      };
      temp.add(t);
    });
    Map<String, dynamic> t1 = {
      // "${DateFormat('dd-MM-yyyy').format(DateTime.now())}": {
      "Products": temp,
      "address": particularAdress,
      "paymentgateway": 'Cash On Delivery',
      "TotalPrice": totalPrice,
      "Date": DateFormat('dd-MM-yyyy').format(DateTime.now())
      // }
    };
    orders.addAll(t1);

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        var tmp = value.data()!['orders'] as Map<String, dynamic>;
        //print(tmp);
        tmp.addAll({
          "${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}": orders
        });

        try {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'orders': tmp, 'cart': [], 'checkoutItems': []});

          String link = "${credentials().realTimeDatabase}Orders.json";
          // print(link);
          // print(orders);
          var client = https.Client();
          await client.get(Uri.parse(link)).then((value) async {
            if (json.decode(value.body) == null) {
              print('true');
              await FirebaseDatabase.instance.reference().child('Orders').set({
                "${FirebaseAuth.instance.currentUser!.displayName.toString()}":
                    tmp
              });
            } else {
              print('false');
              Map<String, dynamic> temp = json.decode(value.body);
              var found = false;
              temp.forEach((key, value) {
                if (key ==
                    FirebaseAuth.instance.currentUser!.displayName.toString()) {
                  found = true;
                  temp[key] = tmp;
                }
              });
              if (found == false) {
                temp.addAll({
                  "${FirebaseAuth.instance.currentUser!.displayName.toString()}":
                      tmp
                });
              }
              await FirebaseDatabase.instance
                  .reference()
                  .update({"Orders": temp});
            }
          });
          // var res = await client.get(Uri.parse(link)) as Map<String, dynamic>;

          // res.update(FirebaseAuth.instance.currentUser!.displayName.toString(),
          //     (value) => tmp);
          // // bool found = false;
          // var temp3 = {};
          // res.forEach((key, value) {
          //   if (key ==
          //       FirebaseAuth.instance.currentUser!.displayName.toString()) {
          //     found = true;
          //     print('$value={value}');
          //     temp3 = value;
          //   }
          // });
          // if (found == false) {
          //   await FirebaseDatabase.instance
          //       .reference()
          //       .child('Orders')
          //       .child(
          //           FirebaseAuth.instance.currentUser!.displayName.toString())
          //       .set({
          //     "${DateFormat('dd-MM-yyyy').format(DateTime.now())}": orders
          //   });
          // } else {
          //   temp3.addAll(
          //       {"${DateFormat('dd-MM-yyyy').format(DateTime.now())}": orders});
          //   await FirebaseDatabase.instance
          //       .reference()
          //       .child('Orders')
          //       .child(
          //           FirebaseAuth.instance.currentUser!.displayName.toString())
          //       .update({
          //     "${DateFormat('dd-MM-yyyy').format(DateTime.now())}": orders
          //   });
          // }
          // var ref = FirebaseDatabase.instance.reference().child('Orders');
          // ref
          //     .child(FirebaseAuth.instance.currentUser!.displayName.toString())
          //     .get()
          //     .then((value) {
          //   List temp = [];
          //   temp = value.value;
          //   temp.addEntries(
          //       {"${DateFormat('dd-MM-yyyy').format(DateTime.now())}": orders});
          //   FirebaseDatabase.instance
          //       .reference()
          //       .child('Orders')
          //       .child(
          //           FirebaseAuth.instance.currentUser!.displayName.toString())
          //       .update(temp);
          // });

          //       var response = await client.post(Uri.parse(link),
          // body: json.encode({
          //   "${FirebaseAuth.instance.currentUser!.displayName}": orders
          // }));
          //print(orders);
          //print(response.statusCode);
        } catch (e) {
          throw (e);
        }
      });
    } catch (e) {
      throw (e);
    }
  }

  Future getOrders() async {
    Map<String, dynamic> temp1 = {};
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        orders = [];
        temp1 = await value.data()!['orders'];
        List<Cart> products = [];
        temp1.forEach((key, element) {
          // print("hi");
          var temp = [];
          products = [];
          temp = element['Products'];
          //print(element['Products']);
          temp.forEach((e) {
            //print(e);
            products.add(Cart(
                packagingIndex: e['packagingIndex'],
                productClass: ProductClass(
                  category: e['Product']['category'],
                  description: e['Product']['description'],
                  id: e['Product']['id'],
                  imageUrl: e['Product']['imageUrl'],
                  packaging: e['Product']['packaging'],
                  title: e['Product']['title'],
                  price: e['Product']['price'],
                ),
                cartCounter: e['cartCounter']));
          });
          print('Products Length =${products.length}');

          orders.add(ORDER(
              Date: key,
              products: products,
              address: ADDRESS(
                  fullName: element['address']['Fullname'],
                  mobilenumber: element['address']['Mobilenumber'],
                  areaColonyStreetSectorVillage: element['address']
                      ['Area,Colony,Street,Sector,Village'],
                  flatHousenoBuildingCompanyApartment: element['address']
                      ['Flat,House no,Building,Company,Apartment'],
                  landmark: element['address']['Landmark'],
                  country: element['address']['Country'],
                  state: element['address']['State'],
                  city: element['address']['City'],
                  pincode: element['address']['Pincode']),
              // cartCounter: element['cartCounter'],
              totalPrice: element['TotalPrice'],
              paymentGateway: element['paymentgateway']));
        });
        print(orders.length);
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
