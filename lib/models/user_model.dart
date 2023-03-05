class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? bio;
  String? location;

  UserModel({this.uid, this.fullname, this.email, this.profilepic, this.bio, this.location});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    bio = map["bio"];
    location = map["location"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "bio": bio,
      "location": location,
    };
  }
}
