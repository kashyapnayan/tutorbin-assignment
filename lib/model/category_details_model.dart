class CategoryDetailsModel {
  String? name;
  int? price;
  bool? instock;
  int? orderCount;
  int? quantity;

  CategoryDetailsModel({this.name, this.price, this.instock, this.orderCount, this.quantity});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    instock = json['instock'];
  }
}