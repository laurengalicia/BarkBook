import 'package:app/bone_button.dart';
import 'package:app/entry_field.dart';
import 'package:flutter/material.dart';

import 'globals/colors.dart';
import 'dog_tag.dart';
import 'folder.dart';

import 'globals/variables.dart';
import 'label.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    Widget dogTag() => GestureDetector(
      onTap: () async {},
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(359/360),
        child: DogTag()
      ),
    );

    Widget folder() => Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Folder(
        title: "MONTYGOLDEN",
        titleColor: titleColor,
        backgroundColor: canvasColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: dogTag(),
            ),
          ],
        ),
      ),
    );

    return Center(
      child: Container(
        width: 225,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Label(currentUser.username),
            ),
            Text(
              "looks like you don't have any pets!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: textOnBackgroundColor,
              ),
            ),
            BoneButton(
              "create profile",
              width: 175,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    insetPadding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EntryField("name"),
                          EntryField(""),
                        ],
                      ),
                    ),
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}