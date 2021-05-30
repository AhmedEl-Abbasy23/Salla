class FavoritesModel {
 late bool status;
 late FavoritesData favoritesData;

 FavoritesModel.fromJson(Map<String, dynamic> json){
   status = json['status'];
   favoritesData = FavoritesData.fromJson(json['data']);
 }
}

class FavoritesData{
  List<Data> data = [];
  FavoritesData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }

}

class Data {
  late int id;
  late FavoriteProduct favoriteProduct;
  Data.fromJson(Map<String, dynamic> json) {
    favoriteProduct = FavoriteProduct.fromJson(json['product']);
  }

}

class FavoriteProduct{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  FavoriteProduct.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}