import 'package:flutter/cupertino.dart';

class Product {
  late String id;
  late String name;
  late String image;
  late double price;
  int quantity;
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1
  });

  double get  totalPrice => price * quantity;

}
