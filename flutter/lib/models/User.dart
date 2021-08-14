class User {
  int? id;
  String displayName;
  String username;

  User({this.id, required this.username, required this.displayName});

  static User fromJson(Map<String, dynamic> json) {
    return new User(
      id: int.parse(json['id'].toString()),
      username: json['username'],
      displayName: json['displayName'],
    );
  }
}
