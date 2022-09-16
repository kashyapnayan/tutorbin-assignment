import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorbin/const/const.dart';
import 'package:tutorbin/model/category_details_model.dart';
import 'package:tutorbin/providers/cart_provider.dart';

class AddRemoveButton extends StatefulWidget {
  final CategoryDetailsModel? categoryDetailsModel;

  const AddRemoveButton({Key? key, required this.categoryDetailsModel})
      : super(key: key);

  @override
  State<AddRemoveButton> createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  late CartProvider cartProvider;

  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, cartModel, child) {
      return (cartProvider.inCartItems
              .containsKey(widget.categoryDetailsModel?.name))
          ? Container(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Const.appPrimaryColor, width: 2),
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (cartProvider.getItemQuantity(
                              widget.categoryDetailsModel!.name!) ==
                          1) {
                        cartProvider
                            .removeItem(widget.categoryDetailsModel!.name!);
                      } else {
                        cartProvider.reduceItemByOne(
                            widget.categoryDetailsModel!.name!);
                      }
                    },
                    child: Text("-",
                        style: TextStyle(
                            color: Const.appPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(
                      cartProvider
                          .inCartItems[widget.categoryDetailsModel?.name]!
                          .quantity
                          .toString(),
                      style: TextStyle(
                          color: Const.appPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      cartProvider.addItemToCart(
                          widget.categoryDetailsModel!.name!,
                          widget.categoryDetailsModel!.price!,
                          widget.categoryDetailsModel!.instock!,
                      );
                    },
                    child: Text("+",
                        style: TextStyle(
                            color: Const.appPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                cartProvider.addItemToCart(widget.categoryDetailsModel!.name!,
                    widget.categoryDetailsModel!.price!,
                    widget.categoryDetailsModel!.instock!);
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Const.appPrimaryColor, width: 2),
                  color: Colors.transparent,
                  borderRadius: BorderRadiusDirectional.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Const.appPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
    });
  }
}
