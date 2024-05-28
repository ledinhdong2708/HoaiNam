class MessageGroupModel {
  String? content;
  String? name;
  DateTime? created;
  MessageGroupModel({
    required this.content,
    required this.name,
  });
  MessageGroupModel.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    created = json["CreateDate"];
    name = json["name"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['name'] = name;
    data['CreateDate'] = created;
    return data;
  }
}
