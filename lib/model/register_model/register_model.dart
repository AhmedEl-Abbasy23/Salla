class RegisterModel {
  late bool status;
  late dynamic message;
  late UserData? data;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null ? null : UserData.fromJson(json['data']);
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  // late int points;
  // late int credit;
  late String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    // points = json['points'];
    // credit = json['credit'];
    token = json['token'];
  }
}

