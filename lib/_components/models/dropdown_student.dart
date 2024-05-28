class DropdownStudent {
  final int id;
  final String name;
  final double chieucao;
  final double cannang;
  DropdownStudent(
      {required this.id,
      required this.name,
      required this.cannang,
      required this.chieucao});
  factory DropdownStudent.fromMap(Map<String, dynamic> json) {
    return DropdownStudent(
        id: json['id'],
        name: json['name'],
        cannang: json['canNang'],
        chieucao: json['chieuCao']);
  }
}
