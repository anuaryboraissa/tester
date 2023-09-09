class LoginUser {
  final String tinNumber;
  final String fullName;
  final String phoneNumber;
  final String userType;
  final String token;
  final String refreshToken;
  LoginUser(
      {required this.tinNumber,
      required this.fullName,
      required this.phoneNumber,
      required this.userType,
      required this.token,
      required this.refreshToken});
}
