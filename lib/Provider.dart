import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/CLASScart.dart';
import 'package:ecommerce/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class provider extends ChangeNotifier {
  //////////////////////////
  var search = false;
  void isSearchEnabeled(bool i) {
    search = i;
    notifyListeners();
  }

  /////////////////////CART////////////////////////////////////////////////

  /////////////////////////GET CART ITEMS///////////////////////////////////
  var cartTotal = 0;
  List<Cart> cartitems = [];
  var temp = [];
  Future getCartItems() async {
    var fire = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(await fire.get('cart'));
    temp = await fire.get('cart');
    cartTotal = 0;
    cartitems = [];
    temp.forEach((element) {
      cartTotal += element['price'] as int;
      cartitems.add(Cart(
          cartCounter: element['cartCounter'],
          productClass: ProductClass(
              id: element['id'],
              category: element['category'],
              price: element['price'],
              title: element['title'],
              imageUrl: element['imageUrl'])));
      print(cartitems.length);
    });

    return cartitems;
  }

  ///////////////////////////ADD CART ITEMS/////////////////////////////////////

  Future addCartItems(Cart cart) async {
    await getCartItems();

    temp.add({
      'id': cart.productClass.id,
      'title': cart.productClass.title,
      'price': cart.productClass.price,
      'category': cart.productClass.category,
      'isFavourite': cart.productClass.isFavourite,
      'imageUrl': cart.productClass.imageUrl,
      'cartCounter': cart.cartCounter,
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'cart': temp,
    });
    //print( await getCartItems());
    // return cartitems;
    // return {
    //   'length': fire.data()!['cart'].length,
    //   'wishlistItems': fire.data()!['cart']
    // };
  }

  ////////////////////////////////////////////////////////////////////////////
  var index = 0;
  /////////////////////////
  var current = 0;
  var qty;
  List<Cart> cartItems = [];
  List<ProductClass> popular = [
    ProductClass(
        category: Product[0]['category'] as String,
        id: Product[0]['id'] as int,
        price: Product[0]['price'] as int,
        title: Product[0]['title'] as String,
        imageUrl: Product[0]['image'] as String),
    ProductClass(
        category: Product[1]['category'] as String,
        id: Product[1]['id'] as int,
        price: Product[1]['price'] as int,
        title: Product[1]['title'] as String,
        imageUrl: Product[1]['image'] as String),
    ProductClass(
        category: Product[2]['category'] as String,
        id: Product[2]['id'] as int,
        price: Product[2]['price'] as int,
        title: Product[2]['title'] as String,
        imageUrl: Product[2]['image'] as String),
    ProductClass(
        category: Product[3]['category'] as String,
        id: Product[3]['id'] as int,
        price: Product[3]['price'] as int,
        title: Product[3]['title'] as String,
        imageUrl: Product[3]['image'] as String)
  ];

  List<ProductClass> favouriteItems = [];

  bool addToCart(ProductClass productClass, String qty) {
    bool found = false;
    cartItems.forEach((element) {
      if (element.productClass.id == productClass.id) found = true;
    });

    if (found) return false;

    cartItems
        .add(Cart(cartCounter: int.parse(qty), productClass: productClass));
    cartTotal += (productClass.price * int.parse(qty));
    return true;
    // cartTotal += productClass.price as Float;
  }

  void addToFavourite(ProductClass productClass) {
    favouriteItems.add(productClass);
    print('Added');
    print(favouriteItems.length);
    notifyListeners();
  }

  void removeFromFavourite(ProductClass productClass) {
    favouriteItems.removeWhere((element) => element.id == productClass.id);
    print('Removed');
    print(favouriteItems.length);
    notifyListeners();
  }

  bool isFavourite(ProductClass productClass) {
    var is1 = favouriteItems.contains(productClass);
    return is1;
  }

  Future addcartItems(int i) async {
    cartitems[i].cartCounter++;
    cartTotal += cartitems[i].productClass.price;

    temp[i]['cartCounter'] = cartitems[i].cartCounter;

    var fire = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'cart': temp})
        .then((value) => notifyListeners())
        .onError((error, stackTrace) => throw('${error}'));

    // cartTotal += double.parse(cartItems[i].productClass.price);
  }

  void removecartItems(int i) {
    if (cartItems[i].cartCounter == 1) {
      cartTotal -= cartitems[i].productClass.price;
      cartItems.removeAt(i);
    } else {
      cartItems[i].cartCounter--;
      cartTotal -= cartItems[i].productClass.price;
    }

    //notifyListeners();
  }

  void increment() {
    if (current == 2)
      current = 0;
    else
      current++;

    notifyListeners();
  }

  void getqty(q) {
    qty = q;
    notifyListeners();
  }
}
