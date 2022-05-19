import 'package:ecommerce/products.dart';

class Cart {
  ProductClass productClass;
  int cartCounter;
  int packagingIndex;

  Cart({
    required this.cartCounter,
     required this.productClass,
     required this.packagingIndex
    });
}
