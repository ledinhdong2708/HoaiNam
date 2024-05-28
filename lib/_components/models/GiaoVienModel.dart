class GiaoVienModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  GiaoVienModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
  });
  GiaoVienModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    username = json["username"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    return data;
  }
}
