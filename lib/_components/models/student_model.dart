class StudentModel {
  final int id;
  final bool IsCompleted;
  final String NameStudent;
  final String Year1;
  final String Year2;
  final String Year3;
  final String Class1;
  final String Class2;
  final String Class3;
  final String GV1;
  final String GV2;
  final String GV3;
  final String CreateDate;
  StudentModel({
    required this.id,
    required this.IsCompleted,
    required this.NameStudent,
    required this.Year1,
    required this.Year2,
    required this.Year3,
    required this.Class1,
    required this.Class2,
    required this.Class3,
    required this.GV1,
    required this.GV2,
    required this.GV3,
    required this.CreateDate,
  });
  factory StudentModel.fromMap(Map<String, dynamic> json) {
    return StudentModel(
        id: json['id'],
        IsCompleted: json['isCompleted'],
        NameStudent: json['nameStudent'],
        Year1: json['year1'],
        Year2: json['year2'],
        Year3: json['year3'],
        Class1: json['class1'],
        Class2: json['class2'],
        Class3: json['class3'],
        GV1: json['gV1'],
        GV2: json['gV2'],
        GV3: json['gV3'],
        CreateDate: json['createDate']);
  }
}
