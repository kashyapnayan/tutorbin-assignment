import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorbin/const/Const.dart';
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
        floatingActionButton: PlaceOrderButton(),
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

  List<Widget> listCategories() {
    List<Widget> addCategories = [];

    addCategories.add(Consumer<CartProvider>(builder: (_, cartModel, child) {
      return (cartModel.popularItems.isNotEmpty)
          ? Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ExpansionTile(
                title: const Text('Popular items'),
                textColor: Const.appPrimaryColor,
                children: listPopularItemsData(cartProvider.popularItems),
              ),
            )
          : const SizedBox.shrink();
    }));

    fetchedData!.forEach((category, data) {
      addCategories.add(Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Text(category.toString()),
          textColor: Const.appPrimaryColor,
          children: listCategoriesData(fetchedData![category]),
        ),
      ));
      addCategories.add(const SizedBox(
        height: 10,
      ));
    });
    return addCategories;
  }

  List<Widget> listCategoriesData(List categoryData) {
    List<Widget> addCategoriesData = [];
    for (int i = 0; i < categoryData.length; i++) {
      addCategoriesData.add(CategoryDataDetailsCard(
          categoryDetailsModel:
              CategoryDetailsModel.fromJson(categoryData[i])));
    }

    return addCategoriesData;
  }

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
