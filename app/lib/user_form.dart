import 'package:app/bone_button.dart';
import 'package:app/entry_field.dart';
import 'package:app/entry_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals/colors.dart';
import 'globals/functions.dart';
import 'globals/variables.dart';
import 'label.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final _formKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {

    print("User Form");

    return Container(
        decoration: BoxDecoration(
            color: backgroundColor
        ),
        padding: const EdgeInsets.all(10),
        child: DottedBorder(
          // strokeWidth: 8,
          // dashPattern: [4, 8],
          strokeWidth: 5,
          dashPattern: [20, 5],
          radius: Radius.circular(10),
          color: textColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                section("USER INFO", fields: userInfo),
                Container(height: 50),
                section("ACCOUNT INFO", fields: accountInfo),
              ],
            ),
          ),
        )
    );
  }

  List<InfoField> userInfo = [
    InfoField( dateString(currentUser.birthDate), label: "date of birth" ),
    InfoField( currentUser.zipCode, label: "zip code" )
  ];

  List<InfoField> accountInfo = [
    InfoField(currentUser.username, label: "username"),
    InfoField(currentUser.email, label: "email"),
    InfoField("✱ ✱ ✱ ✱ ✱", label: "password")
  ];

  Widget section(label, {required List<Widget> fields}) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      RotationTransition(
          turns: AlwaysStoppedAnimation(358/360),
          child: Label(label)
      ),
      Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: fields
      )
    ],
  );

  void refresh() => setState(() { });
}

class InfoField extends StatelessWidget {
  final String value;
  final String label;
  const InfoField(this.value, {Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: 5
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        RotationTransition(
          turns: AlwaysStoppedAnimation(2/360),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 0.25,
                    spreadRadius: 1,
                    color: Colors.black.withAlpha(75)
                )
              ],
              color: textColor,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                value,
                style: GoogleFonts.lexend(
                    fontSize: 20,
                    color: primaryColorDark
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
