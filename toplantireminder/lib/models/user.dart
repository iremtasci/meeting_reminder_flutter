class User {
  String takim;
  bool admin;

  User(this.takim);

  Map<String, dynamic> toJson() => {
    'takim': takim,
    'admin': admin,
  };
}