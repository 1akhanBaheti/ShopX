import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/CLASScart.dart';
import 'package:ecommerce/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class provider extends ChangeNotifier {
  //////////////////////////
  var search = false;
  var searchItemList = [];

  void isSearchEnabeled(bool i) {
    search = i;
    notifyListeners();
  }

  /////////////////////CART////////////////////////////////////////////////

  /////////////////////////GET CART ITEMS///////////////////////////////////
  var cartTotal = 0;
  List<Cart> cartitems = [];
  List<ProductClass> saveForLater = [];
  var temp = [];
  var saveForLaterTemp = [];

  Future getCartItems() async {
    await getSavedForLaterProducts();
    try {
      var fire = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      // print(await fire.get('cart'));
      temp = await fire.get('cart');
      cartTotal = 0;
      cartitems = [];
      // print(temp);
      temp.forEach((element) {
        cartTotal += element['price'] * element['cartCounter'] as int;
        cartitems.add(Cart(
            cartCounter: element['cartCounter'],
            productClass: ProductClass(
                description: element['description'],
                id: element['id'],
                category: element['category'],
                price: element['price'],
                title: element['title'],
                imageUrl: element['imageUrl'])));
      });
      return temp;
    } catch (e) {
      throw (e);
    }
  }

  ///////////////////////////ADD CART ITEMS/////////////////////////////////////

  Future addCartItems(Cart cart) async {
    await getCartItems();

    temp.add({
      'description': cart.productClass.description,
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

    cartitems.add(cart);
  }

  ////////////////////////////////////////////////////////////////////////////
  var index = 0;
  /////////////////////////
  var current = 0;
  var qty;
  // List<Cart> cartItems = [];

  List<ProductClass> favouriteItems = [];

  Future getWishlistItems() async {
    var temp = [];
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    try {
      await instance.get().then((value) async {
        temp = await value.data()!['wishlist'];
        favouriteItems = [];
        print(temp);
        temp.forEach((element) {
          favouriteItems.add(ProductClass(
              description: element['description'],
              id: element['id'],
              category: element['category'],
              price: element['price'],
              title: element['title'],
              imageUrl: element['imageUrl']));
        });
        print(favouriteItems.length);
      });
      return temp;
    } catch (e) {
      throw (e);
    }
  }

  Future addToFavourite(ProductClass productClass) async {
    var favouriteTemp = [];
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    try {
      await instance.get().then((value) async {
        favouriteTemp = await value.data()!['wishlist'];

        favouriteTemp.add({
          'description': productClass.description,
          'id': productClass.id,
          'title': productClass.title,
          'price': productClass.price,
          'category': productClass.category,
          'isFavourite': productClass.isFavourite,
          'imageUrl': productClass.imageUrl,
        });
        favouriteItems.add(productClass);
        instance.update({'wishlist': favouriteTemp});
      });
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future removeFromFavourite(ProductClass productClass) async {
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var favouriteTemp = [];

    try {
      instance.get().then((value) async {
        favouriteTemp = await value.data()!['wishlist'];

        favouriteTemp
            .removeWhere((element) => element['id'] == productClass.id);

        int index;
        print(favouriteItems.length);
        favouriteItems.removeWhere((element) => element.id == productClass.id);
        print(favouriteItems.length);
        instance.update({'wishlist': favouriteTemp}).then((value) {
          notifyListeners();
        });
      });
    } catch (e) {
      throw (e);
    }
  }

  Future moveToBagFromFavourite(int index) async {
    try {
      var element =
          Cart(cartCounter: 1, productClass: favouriteItems.elementAt(index));

      await addCartItems(element);
      await removeFromFavourite(element.productClass);
    } catch (e) {
      throw (e);
    }
  }

  bool isFavourite(ProductClass productClass) {
    bool is1 = false;
    favouriteItems.forEach((element) {
      if (element.id == productClass.id) is1 = true;
    });

    return is1;
  }

  Future addcartItems(int i) async {
    cartitems[i].cartCounter++;
    print(cartTotal);
    cartTotal += cartitems[i].productClass.price;
    print(cartTotal);

    temp[i]['cartCounter'] = cartitems[i].cartCounter;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'cart': temp}).then((value) => null);
      return notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  void removecartItems(int i) async {
    if (cartitems[i].cartCounter == 1) {
      cartTotal -= cartitems[i].productClass.price;
      cartitems.removeAt(i);
      temp.removeAt(i);
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'cart': temp}).then((value) => null);
        return notifyListeners();
      } catch (e) {
        throw (e);
      }
    } else {
      cartitems[i].cartCounter--;
      cartTotal -= cartitems[i].productClass.price;
      temp[i]['cartCounter'] = cartitems[i].cartCounter;
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'cart': temp}).then((value) => null);
        return notifyListeners();
      } catch (e) {
        throw (e);
      }
    }
  }

  Future addToSaveForLater(Cart cart) async {
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var latertemp = [];
    var carttemp = temp;

    try {
      await instance.get().then((value) async {
        latertemp = value.data()!['saveForLater'];
        latertemp.add({
          'description': cart.productClass.description,
          'id': cart.productClass.id,
          'title': cart.productClass.title,
          'price': cart.productClass.price,
          'category': cart.productClass.category,
          'isFavourite': cart.productClass.isFavourite,
          'imageUrl': cart.productClass.imageUrl,
        });

        carttemp
            .removeWhere((element) => element['id'] == cart.productClass.id);
        await instance.update({'saveForLater': latertemp});
        await instance.update({'cart': carttemp});

        saveForLater = [];

        latertemp.forEach((element) {
          saveForLater.add(ProductClass(
              description: element['description'],
              id: element['id'],
              category: element['category'],
              price: element['price'],
              title: element['title'],
              imageUrl: element['imageUrl']));
        });
      });
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future getSavedForLaterProducts() async {
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var temp = [];
    saveForLater = [];
    try {
      instance.get().then((value) async {
        temp = await value.data()!['saveForLater'];
        saveForLaterTemp = temp;
        temp.forEach((element) {
          saveForLater.add(ProductClass(
              description: element['description'],
              id: element['id'],
              category: element['category'],
              price: element['price'],
              title: element['title'],
              imageUrl: element['imageUrl']));
        });
      });
    } catch (e) {
      throw (e);
    }
  }

  Future moveToCartFromSavedForLater(int index) async {
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    temp.add({
      'id': saveForLater[index].id,
      'title': saveForLater[index].title,
      'price': saveForLater[index].price,
      'category': saveForLater[index].category,
      'isFavourite': saveForLater[index].isFavourite,
      'imageUrl': saveForLater[index].imageUrl,
      'cartCounter': 1,
      'description': saveForLater[index].description
    });
    saveForLaterTemp
        .removeWhere((element) => element['id'] == saveForLater[index].id);

    try {
      instance.update({'cart': temp, 'saveForLater': saveForLaterTemp}).then(
          (value) {
        notifyListeners();
      });
    } catch (e) {
      throw (e);
    }
  }

  Future removeFromSavedForLater(int index) async {
    var instance = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var latertemp = [];
    saveForLater.removeAt(index);
    saveForLater.forEach((element) {
      latertemp.add({
        'id': element.id,
        'title': element.title,
        'price': element.price,
        'category': element.category,
        'isFavourite': element.isFavourite,
        'imageUrl': element.imageUrl,
        'description': element.description,
      });
    });

    try {
      instance.update({'saveForLater': latertemp}).then((value) {
        notifyListeners();
      });
    } catch (e) {
      throw (e);
    }
  }
  /////////////////////////IN CHECKOUT SCREEN////////////////////////

  Future increment(int index, int value) async {
    cartitems[index].cartCounter = value;
    notifyListeners();
  }

  Future updateQty(int index, int value) async {
    temp[index]['cartCounter'] = value;
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'cart': temp}).then((value) {});
      return notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

//////////////////////////////////////////////
  void getqty(q) {
    qty = q;
    notifyListeners();
  }
}

////////////////////////////////// SEARCH IMPLEMENTATION ////////////////////////////////////

void searchProducts(String s) {}



   





//////////////////////////////////////////////////////////////////////////////////////////////
