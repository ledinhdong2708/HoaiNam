class GroupModel {
  int? id;
  String? name;
  GroupModel({
    required this.id,
    required this.name,
  });
  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
