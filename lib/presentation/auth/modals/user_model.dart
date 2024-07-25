class UserModel {
  final String userId;
  final String email;
  final DateTime createDate;
  final String userName;
  final bool allowLogin;
  final String profilePic;

  const UserModel({
    required this.createDate,
    required this.email,
    required this.userId,
    required this.allowLogin,
    required this.userName,
    this.profilePic = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime createDate = DateTime.parse(json['create_date']);
    return UserModel(
      createDate: createDate,
      email: json['email'],
      userId: json['user_id'],
      allowLogin: json['allow_login'],
      userName: json['user_name'],
      profilePic: "",
    );
  }

  Map<String, dynamic> toJson() {
    // "profile_pic":

    return {
      "user_id": userId,
      "email": email,
      "create_date": createDate.toString(),
      "allow_login": allowLogin,
      "user_name": userName,
    };
  }
}
