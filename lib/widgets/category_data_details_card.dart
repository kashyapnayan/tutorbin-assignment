import 'package:flutter/material.dart';
import 'package:tutorbin/model/category_details_model.dart';
import 'package:tutorbin/widgets/add_remove_button.dart';

class CategoryDataDetailsCard extends StatefulWidget {
  final CategoryDetailsModel? categoryDetailsModel;

  const CategoryDataDetailsCard({Key? key, required this.categoryDetailsModel})
      : super(key: key);

  @override
  State<CategoryDataDetailsCard> createState() =>
      _CategoryDataDetailsCardState();
}

class _CategoryDataDetailsCardState extends State<CategoryDataDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.categoryDetailsModel?.name ?? "N/A",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                        "\$ ${widget.categoryDetailsModel?.price.toString() ?? "N/A"}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                    (widget.categoryDetailsModel?.instock ?? false)
                        ? const SizedBox()
                        : Column(
                            children: const [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Sorry, Currently Out of Stock!"),
                            ],
                          ),
                  ],
                )),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: (widget.categoryDetailsModel?.instock ?? false)
                        ? AddRemoveButton(
                            categoryDetailsModel: widget.categoryDetailsModel,
                          )
                        : const SizedBox.shrink())
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}