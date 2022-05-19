import 'package:ecommerce/CLASScart.dart';
import 'package:ecommerce/adressDataModel.dart';

class ORDER {
  List<Cart> products;
  ADDRESS address;
  // int cartCounter;
  int totalPrice;
  String paymentGateway;
  String Date;

  ORDER(
      {
      required this.Date,
      required this.products,
      required this.address,
      // required this.cartCounter,
      required this.totalPrice,
      required this.paymentGateway});
}

class Order {}
