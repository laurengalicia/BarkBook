import 'package:cloud_firestore/cloud_firestore.dart';

import 'globals/functions.dart';
import 'globals/variables.dart';

class BarkBookUser {
  late String id;
  late bool isActive;
  late DateTime lastActiveOn;
  late DateTime birthDate;
  late String zipCode;
  late String email;
  late String username;
  late List pets;
  late List following;
  late List friends;
  bool? isLightMode;

  BarkBookUser({
    required this.id,
    required this.isActive,
    required this.lastActiveOn,
    required this.birthDate,
    required this.zipCode,
    required this.email,
    required this.username,
    required this.pets,
    required this.following,
    required this.friends,
    this.isLightMode = false,
  });

  BarkBookUser.empty() {
    this.id = "";
    this.isActive = false;
    this.lastActiveOn = DateTime.now();
    this.birthDate = DateTime.now();
    this.zipCode = "";
    this.email = "";
    this.username = "";
    this.pets = [];
    this.following = [];
    this.friends = [];
    this.isLightMode = false;
  }

  static Future<BarkBookUser> fromID(String id) async {
    print("BarkBookUser.fromID($id)");

    DocumentSnapshot doc = await userDoc(id).get();

    return BarkBookUser(
      id: id,
      isActive: doc['isActive'],
      lastActiveOn: doc['lastActiveOn'].toDate(),
      birthDate: doc['birthDate'].toDate(),
      zipCode: doc['zipCode'],
      email: doc['email'],
      username: doc['username'],
      pets: doc['pets'],
      following: doc['following'],
      friends: doc['friends'],
    );
  }

  BarkBookUser.fromDoc(doc) {
    this.id = doc['id'];
    this.isActive =  doc['isActive'];
    this.lastActiveOn = doc['lastActiveOn'].toDate();
    this.birthDate = doc['birthDate'].toDate();
    this.zipCode = doc['zipCode'];
    this.email = doc['email'];
    this.username = doc['username'];
    this.pets = doc['pets'];
    this.following = doc['following'];
    this.friends = doc['friends'];
    this.isLightMode =  doc['isLightMode'];
  }

  factory BarkBookUser.fromJson(Map<String, dynamic> json) {
    return BarkBookUser(
      id: json['id'] as String,
      isActive: json['is_active'] as bool,
      lastActiveOn: json['last_active_on'] as DateTime,
      birthDate: json['birth_date'] as DateTime,
      zipCode: json['zip_code'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      pets: json['pets'] as List,
      following: json['following'] as List,
      friends: json['friends'] as List,
      isLightMode: json['isLightMode'] as bool,
    );
  }
}
