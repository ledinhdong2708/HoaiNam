class Months {
  final int id;
  final String name;
  Months({required this.id, required this.name});
  factory Months.fromMap(Map<String, dynamic> json) {
    return Months(id: json['id'], name: json['name']);
  }
}