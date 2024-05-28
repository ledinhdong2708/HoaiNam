class Classs {
  final int id;
  final String name;
  Classs({required this.id, required this.name});
  factory Classs.fromMap(Map<String, dynamic> json) {
    return Classs(id: json['id'], name: json['name']);
  }
}