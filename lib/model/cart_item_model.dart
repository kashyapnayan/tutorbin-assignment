import 'package:flutter/material.dart';

class CartItemModel with ChangeNotifier {
  final String name;
  final int price;
  final int quantity;

  CartItemModel(
      {required this.name, required this.price, required this.quantity});
}
