import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../user.dart';

const String symbols = r"~`! @#$%^&*()_+={[}]|\:;<,>.?/-";
final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

List<String> breeds = [];

BuildContext? buildContext;

MediaQueryData screen = MediaQuery.of(buildContext!);

ThemeData theme = Theme.of(buildContext!);
TextTheme textTheme = theme.textTheme;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> users = firestore.collection('users');
CollectionReference<Map<String, dynamic>> pets = firestore.collection('pets');

BarkBookUser currentUser = BarkBookUser.empty();