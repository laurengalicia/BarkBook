import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../globals/colors.dart';
import '../globals/functions.dart';
import '../globals/variables.dart';

import '../user.dart';

import '../barkbook.dart';
import '../sign_in_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    Future<BarkBookUser> getUser() async {
      DocumentSnapshot<Object?> doc = await userDoc(auth.currentUser!.uid).get();
      if(doc.exists) {
        currentUser = BarkBookUser.fromDoc(doc);
      }
      else {
        currentUser.isActive = true;
        currentUser.id = auth.currentUser!.uid;
        currentUser.email = auth.currentUser!.email!;
        print("getUser: new");
        await userDoc(currentUser.id).set({
          "timestamp": DateTime.now(),
          "id": currentUser.id,
          "isActive": true,
          "email": currentUser.email,
          "username": currentUser.username,
          "birthDate": currentUser.birthDate,
          "zipCode": currentUser.zipCode,
          "pets": [],
          "following": [],
          "friends": [],
          "isLightMode": false,
        }, SetOptions(merge: true));
      }
      return currentUser;
    }

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      initialData: auth.currentUser,
      builder: (context, authUser) {
        if(authUser.hasData) {
          String authUserID = authUser.requireData!.uid;
          return FutureBuilder<BarkBookUser>(
              future: getUser(),
              builder: (context, barkBookUser) {
                print("FutureBuilder: authUserID: $authUserID");
                if(barkBookUser.hasData) {
                  currentUser = barkBookUser.requireData;
                  userDoc(currentUser.id).set({
                    "lastActiveOn": DateTime.now(),
                  }, SetOptions(merge: true));
                  return const BarkBook();
                } else if(barkBookUser.hasError) {
                  print("error: ${barkBookUser.error}");
                }
                print("FutureBuilder end");
                return Container(
                  color: primaryColor,
                  child: Center(
                    child: CircularProgressIndicator(color: textColor),
                  ),
                );
              }
          );
        }
        currentUser = BarkBookUser.empty();
        return const SignInPage();
      },
    );
  }
}