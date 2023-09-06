class LoginUser {
  final String tinNumber;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userType;
  final String token;
  final String refreshToken;
  LoginUser(
      {required this.tinNumber,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.userType,
      required this.token,
      required this.refreshToken});
}
