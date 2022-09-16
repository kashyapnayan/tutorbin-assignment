import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorbin/const/const.dart';
import 'package:tutorbin/model/category_details_model.dart';
import 'package:tutorbin/providers/cart_provider.dart';
import 'package:tutorbin/providers/home_provider.dart';
import 'package:tutorbin/widgets/category_data_details_card.dart';
import 'package:tutorbin/widgets/place_order_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider homeProvider;
  late CartProvider cartProvider;
  Map<String, dynamic>? fetchedData;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    getData();
  }

  ///This method will help retrieve necessary data from asset [menu.json] file
  Future<void> getData() async {
    await homeProvider.collectData();
    fetchedData = homeProvider.mockData;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Const.appPrimaryColor,
        ),
        body: (fetchedData != null && fetchedData!.isNotEmpty)
            ? SingleChildScrollView(child: _loadData())
            : showProgressIndicator(),
        floatingActionButton: const PlaceOrderButton(),
      );
    });
  }

  Widget showProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _loadData() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: listCategories(),
      ),
    );
  }

  ///List Items category wise along with popular item
  ///The [Best Seller] teg will come only for those items
  ///which has been ordered more than one time
  List<Widget> listCategories() {
    List<Widget> addCategories = [];

    ///this will render popular items if any
    ///if an order is placed for that item that item will be render
    ///with the help of this From line[76 to 97]
    addCategories.add(Consumer<CartProvider>(builder: (_, cartModel, child) {
      return (cartModel.popularItems.isNotEmpty)
          ? Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Popular items', style: TextStyle(fontSize: 16),),
                    Text('${cartProvider.popularItems.length}',style: const TextStyle(fontSize: 16),)
                  ],
                ),
                textColor: Const.appPrimaryColor,
                collapsedIconColor: Colors.black,
                iconColor: Const.appPrimaryColor,
                collapsedTextColor: Colors.black,
                children: listPopularItemsData(cartProvider.popularItems),
              ),
            )
          : const SizedBox.shrink();
    }));

    ///This will render the each category available in [menu.json] asset file
    fetchedData!.forEach((category, data) {
      addCategories.add(Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.toString(),style: const TextStyle(fontSize: 16),),
              Text('${fetchedData![category].length}',style: const TextStyle(fontSize: 16),)
            ],
          ),
          textColor: Const.appPrimaryColor,
          collapsedIconColor: Colors.black,
          iconColor: Const.appPrimaryColor,
          collapsedTextColor: Colors.black,
          children: listCategoriesData(fetchedData![category]),
        ),
      ));
      addCategories.add(const SizedBox(
        height: 10,
      ));
    });
    return addCategories;
  }

  ///this method renders items for each category
  List<Widget> listCategoriesData(List categoryData) {
    List<Widget> addCategoriesData = [];
    for (int i = 0; i < categoryData.length; i++) {
      addCategoriesData.add(CategoryDataDetailsCard(
          categoryDetailsModel:
              CategoryDetailsModel.fromJson(categoryData[i])));
    }

    return addCategoriesData;
  }

  ///This method renders the popular items
  List<Widget> listPopularItemsData(
      Map<String, CategoryDetailsModel> popularItems) {
    List<Widget> addPopularData = [];
    popularItems.forEach((itemName, popularItem) {
      addPopularData
          .add(CategoryDataDetailsCard(categoryDetailsModel: popularItem));
    });

    return addPopularData;
  }
}
