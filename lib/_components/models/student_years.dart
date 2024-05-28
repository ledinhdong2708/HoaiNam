class StudentYear {
  final int id;
  final String name;
  StudentYear({required this.id, required this.name});
  factory StudentYear.fromMap(Map<String, dynamic> json) {
    return StudentYear(id: json['id'], name: json['name']);
  }
}
