class DiemDanhModel {
  final bool coPhep;
  final String content;
  final String createDate;
  final bool denLop;
  final int id;
  final bool isCompleted;
  final bool khongPhep;
  final int role;
  final int studentId;
  final String updateDate;
  final int userId;
  DiemDanhModel(
      {required this.coPhep,
      required this.content,
      required this.createDate,
      required this.denLop,
      required this.id,
      required this.isCompleted,
      required this.khongPhep,
      required this.role,
      required this.studentId,
      required this.updateDate,
      required this.userId});
  factory DiemDanhModel.fromMap(Map<String, dynamic> json) {
    return DiemDanhModel(
        coPhep: json['coPhep'],
        content: json['content'],
        createDate: json['createDate'],
        denLop: json['denLop'],
        id: json['id'],
        isCompleted: json['isCompleted'],
        khongPhep: json['khongPhep'],
        role: json['role'],
        studentId: json['studentId'],
        updateDate: json['studentId'],
        userId: json['studentId']
    );
  }
}
