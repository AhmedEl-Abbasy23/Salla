class FavoritesDataModel {
  late bool status;
  late String message;

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
