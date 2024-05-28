class EmailModel {
  String? body;
  String? subject;
  EmailModel({
    required this.body,
    required this.subject,
  });
  EmailModel.fromJson(Map<String, dynamic> json) {
    body = json["body"];
    subject = json["subject"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['subject'] = subject;
    return data;
  }
}
