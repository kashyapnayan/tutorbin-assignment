import 'package:flutter/material.dart';
import 'package:tutorbin/model/category_details_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CategoryDetailsModel> _inCartItems = {};

  Map<String, CategoryDetailsModel> get inCartItems => _inCartItems;

  late double _totalAmount = 0.00;

  double get totalAmount => _totalAmount;

  final Map<String, CategoryDetailsModel> _popularItems = {};

  Map<String, CategoryDetailsModel> get popularItems => _popularItems;

  ///this method will add the item to Cart
  void addItemToCart(String itemName, double itemPrice, bool inStock) {
    if (_inCartItems.containsKey(itemName)) {
      _inCartItems.update(
          itemName,
          (existingCartItem) => CategoryDetailsModel(
              name: existingCartItem.name,
              price: existingCartItem.price,
              instock: inStock,
              quantity: existingCartItem.quantity! + 1));
    } else {
      _inCartItems.putIfAbsent(
          itemName,
          () => CategoryDetailsModel(
              name: itemName, instock: inStock,price: itemPrice, quantity: 1));
    }
    _totalAmount += itemPrice;
    notifyListeners();
  }

  ///this method will reduce the item quantity by one from the cart
  void reduceItemByOne(String itemName) {
    if (_inCartItems.containsKey(itemName)) {
      CategoryDetailsModel localItem;
      _inCartItems.update(itemName, (existingCartItem) {
        localItem = existingCartItem;
        _totalAmount -= localItem.price!;
        return CategoryDetailsModel(
            name: existingCartItem.name,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity! - 1);
      });
    }
    notifyListeners();
  }

  ///this method will return total added quantity of an item
  int getItemQuantity(String itemName) {
    return _inCartItems[itemName]?.quantity ?? 0;
  }

  ///this method will remove the item from cart
  void removeItem(String itemName) {
    _totalAmount -= _inCartItems[itemName]!.price!;
    _inCartItems.remove(itemName);
    notifyListeners();
  }

  ///this method will completely clear the cart
  void clearCart() {
    _inCartItems.clear();
    _totalAmount = 0.0;
    notifyListeners();
  }

  ///this method will add items to popular Products for which order was placed
  void placeOrder() {
    _inCartItems.forEach((itemName, cartItemModel) {
      if (_popularItems.containsKey(itemName)) {
        _popularItems.update(
            itemName,
            (existingItem) => CategoryDetailsModel(
                name: itemName,
                price: cartItemModel.price,
                instock: cartItemModel.instock,
                orderCount: existingItem.orderCount! + 1));
      } else {
        _popularItems.putIfAbsent(
            itemName,
            () => CategoryDetailsModel(
                  name: itemName,
                  price: cartItemModel.price,
                  instock: cartItemModel.instock,
                  orderCount: 1,
                ));
      }
    });
    clearCart();
    notifyListeners();
  }
}
