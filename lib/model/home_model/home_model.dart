class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    // print(json['banners'].runtimeType);
    // print(json['products'].runtimeType);
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
      // print(ProductsModel.fromJson(element).runtimeType);
    });
  }
}

class BannersModel {
  late int id;
  late String image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
