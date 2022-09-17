class CategoryDetailsModel {
  String? name;
  double? price;
  bool? instock;
  int? orderCount;
  int? quantity;

  CategoryDetailsModel({this.name, this.price, this.instock, this.orderCount, this.quantity});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.parse(double.parse(json['price'].toString()).toStringAsFixed(2));
    instock = json['instock'];
  }
}