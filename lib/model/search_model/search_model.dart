class SearchModel {
  late bool status;
  late SearchData searchData;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    searchData = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  List<SearchProduct> data = [];

  SearchData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(SearchProduct.fromJson(element));
    });
  }
}

class SearchProduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int? discount;
  late String image;
  late String name;

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
