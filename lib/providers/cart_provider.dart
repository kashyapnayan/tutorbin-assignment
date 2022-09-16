import 'package:flutter/material.dart';
import 'package:tutorbin/model/cart_item_model.dart';
import 'package:tutorbin/model/popular_items_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItemModel> _inCartItems = {};

  Map<String, CartItemModel> get inCartItems => _inCartItems;

  late double _totalAmount = 0.0;

  double get totalAmount => _totalAmount;

  final Map<String, PopularItemsModel> _popularItems = {};

  Map<String, PopularItemsModel> get popularItems => _popularItems;

  late bool _isPlacingOrder = false;

  bool get isPlacingOrder => _isPlacingOrder;

  ///this method will add the item to Cart
  void addItemToCart(String itemName, int itemPrice) {
    if (_inCartItems.containsKey(itemName)) {
      _inCartItems.update(
          itemName,
          (existingCartItem) => CartItemModel(
              name: existingCartItem.name,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _inCartItems.putIfAbsent(itemName,
          () => CartItemModel(name: itemName, price: itemPrice, quantity: 1));
    }
    _totalAmount += itemPrice;
    notifyListeners();
  }

  ///this method will reduce the item quantity by one from the cart
  void reduceItemByOne(String itemName) {
    if (_inCartItems.containsKey(itemName)) {
      CartItemModel localItem;
      _inCartItems.update(itemName, (existingCartItem) {
        localItem = existingCartItem;
        _totalAmount -= localItem.price;
        return CartItemModel(
            name: existingCartItem.name,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1);
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
    _totalAmount -= _inCartItems[itemName]!.price;
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
    _isPlacingOrder = true;
    _inCartItems.forEach((itemName, cartItemModel) {
      if (_popularItems.containsKey(itemName)) {
        _popularItems.update(
            itemName,
            (existingItem) => PopularItemsModel(
                name: itemName,
                price: cartItemModel.price,
                orderCount: existingItem.orderCount + 1));
      } else {
        _popularItems.putIfAbsent(
            itemName,
            () => PopularItemsModel(
                name: itemName, price: cartItemModel.price, orderCount: 1));
      }
    });
    _isPlacingOrder = false;
    clearCart();
    notifyListeners();
  }
}
