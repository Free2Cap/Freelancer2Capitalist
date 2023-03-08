class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? bio;
  String? location;
  DateTime? lastSeen;
  bool? isActive;
  bool? isTyping;

  UserModel(
      {this.uid,
      this.fullname,
      this.email,
      this.profilepic,
      this.bio,
      this.location,
      this.lastSeen,
      this.isActive,
      this.isTyping});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    bio = map["bio"];
    location = map["location"];
    lastSeen = map["lastseen"].toDate();
    isActive = map["isActive"];
    isTyping = map["isTyping"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "bio": bio,
      "location": location,
      "lastseen": lastSeen,
      "isActive": isActive,
      "isTyping": isTyping,
    };
  }
}
