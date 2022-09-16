import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Services{
  static final Services _services = Services._internal();

  factory Services() => _services;

  Services._internal();

  void showToastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}