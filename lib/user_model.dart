class User {
  final int userId;
  final String userName;
  final String userEmail;
  final String userUserName;

  User({required this.userName, required this.userUserName, required this.userId, required this.userEmail});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["id"],
      userName: json["name"],
      userUserName: json["username"],
      userEmail: json["email"],
    );
  }
}

