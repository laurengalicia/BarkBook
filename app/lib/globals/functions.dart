import 'package:cloud_firestore/cloud_firestore.dart';

import 'variables.dart';

DocumentReference userDoc(String id) => users.doc(id);
DocumentReference currentUserDoc() => userDoc(auth.currentUser!.uid);

double relativeSize(factor) =>
    factor * (
        screen.size.width == screen.size.shortestSide
            ? screen.size.width
            : screen.size.shortestSide
    );

int age(DateTime birthDate) =>
    DateTime.now().difference(birthDate).inDays ~/ 365;

String dateString(DateTime date) =>
    "${months[date.month-1]} ${date.day}, ${date.year}";