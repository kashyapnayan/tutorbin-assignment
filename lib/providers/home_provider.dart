import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorbin/const/const.dart';

class HomeProvider with ChangeNotifier {
  final List<String> _categories = [];

  Map<String,dynamic> _mockData = {};

  List<String> get categories => _categories;

  Map<String, dynamic> get mockData => _mockData;

  ///This method is collecting data from [menu.json] file
  ///and updating required fields [_mockData] and [_categories]
  Future<void> collectData()async{
    String mockResponse = await rootBundle.loadString(Const.mockResponseAddress);
    _mockData = json.decode(mockResponse);
    _mockData.forEach((category, categoryData) {
      _categories.add(category);
    });
    notifyListeners();
  }

}
