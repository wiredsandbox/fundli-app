class UserAuthModel {
  String email;
  String id;
  String firstName;
  String lastName;
  String token;

  UserAuthModel({
    required this.id,
    required this.email,
    required this.lastName,
    required this.firstName,
    required this.token,
  });
}
