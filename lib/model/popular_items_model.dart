import 'package:flutter/material.dart';

class PopularItemsModel with ChangeNotifier {
  final String name;
  final int price;
  final int orderCount;

  PopularItemsModel({
    required this.name,
    required this.price,
    required this.orderCount,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = this.name;
    data['price'] = this.price;
    data['orderCount'] = this.orderCount;
    return data;
  }
}
