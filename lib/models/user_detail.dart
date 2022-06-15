class UserDetail {
  String? username;
  String? email;
  String? photoURL;

  UserDetail({this.username, this.email, this.photoURL});

  UserDetail.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    photoURL = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['photoUrl'] = photoURL;
    return data;
  }
}