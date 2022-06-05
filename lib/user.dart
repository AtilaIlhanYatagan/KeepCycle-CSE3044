import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String gender;
  final String height;
  final String name;
  final String weight;

  User({
    required this.height,
    required this.email,
    required this.weight,
    required this.gender,
    required this.name,
});
  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      email: doc["email"],
      gender: doc["gender"],
      height: doc["height"],
      name: doc["name"],
      weight: doc["weight"],
    );
  }

}