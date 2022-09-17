import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorbin/providers/cart_provider.dart';
import 'package:tutorbin/services/services.dart';

import '../const/const.dart';

class PlaceOrderButton extends StatefulWidget {
  const PlaceOrderButton({Key? key}) : super(key: key);

  @override
  State<PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends State<PlaceOrderButton> {
  late CartProvider cartProvider;

  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, model, child) {
      return (model.totalAmount > 0)
          ? SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.placeOrder();
                    Services().showToastMessage('Your Order is placed!');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Const.appPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      'Place Order \$${model.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
