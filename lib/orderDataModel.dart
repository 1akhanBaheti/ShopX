import 'package:ecommerce/adressDataModel.dart';
import 'package:ecommerce/products.dart';

class ORDER {
  ProductClass product;
  ADDRESS address;
  int cartCounter;
  int totalPrice;
  String paymentGateway;

  ORDER(
      {required this.product,
      required this.address,
      required this.cartCounter,
      required this.totalPrice,
      required this.paymentGateway});
}
