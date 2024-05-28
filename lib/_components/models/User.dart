class UserList {
  final int id;
  final String name;
  UserList({required this.id, required this.name});
  factory UserList.fromMap(Map<String, dynamic> json) {
    return UserList(id: json['id'], name: json['username']);
  }
}
