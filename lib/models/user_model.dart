class UserModel {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;

  UserModel({required this.id,required this.email,required this.avatar,required this.firstname,required this.lastname});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstname: json['first_name'] ?? 'First Name',
      lastname: json['last_name'] ?? 'Last Name',
      avatar: json['avatar'] ?? 'https://reqres.in/img/faces/7-image.jpg',
    );
  }
}
