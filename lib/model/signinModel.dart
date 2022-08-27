class userModel {
  String uid, name, email, profilePic;

  userModel(
      {required this.uid,
      required this.email,
      required this.profilePic,
      required this.name});

  userModel.fromMap(Map<String, dynamic>? map, this.uid)
      : name = map!['name'] ?? '',
        email = map["email"] ?? '',
        profilePic = map["profilePic"] ?? '';

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['profilePic'] = profilePic;

    return map;
  }
}
