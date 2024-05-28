class KhoaHocModel {
  int? id;
  String? name;
  KhoaHocModel({
    required this.id,
    required this.name,
    // required this.toYear,
  });
  KhoaHocModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    // fromYear = json["fromYear"];
    // toYear = json["toYear"];
    name = json["fromYear"].toString() + " - " + json["toYear"].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
