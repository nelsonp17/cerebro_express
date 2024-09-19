class UserCredential {
  final String email;
  final String? password;

  UserCredential({required this.email, this.password});
}

class UserData extends UserCredential {
  final int id;
  final String uuid;
  final String avantar;

  UserData(
      {required super.email,
      super.password,
      required this.id,
      required this.uuid,
      required this.avantar});
}
