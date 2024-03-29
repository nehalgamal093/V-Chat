class LoginResponse {
  String id;
  String username;
  String fullName;
  String profilePic;

  LoginResponse(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.profilePic});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        id: json['_id'],
        username: json['username'],
        fullName: json['fullName'],
        profilePic: json['profilePic']);
  }
}
