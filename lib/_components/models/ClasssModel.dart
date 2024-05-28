class ClasssModel {
  int? id;
  String? name;
  ClasssModel({
    required this.id,
    required this.name,
  });
  ClasssModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["nameClass"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
