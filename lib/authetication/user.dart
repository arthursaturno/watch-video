import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? name;
  String? email;
  String? image;

  User({
    this.uid,
    this.name,
    this.email,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "image": image,
      };
  static User fromSnap(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      email: dataSnapshot["email"],
      image: dataSnapshot["image"],
    );
  }
}
