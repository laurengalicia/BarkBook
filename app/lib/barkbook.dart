import 'package:app/bone_button.dart';
import 'package:app/user_form.dart';
import 'globals/colors.dart';

import 'label.dart';
import 'profile_page.dart';
import 'package:flutter/material.dart';
import 'globals/variables.dart';

class BarkBook extends StatefulWidget {
  const BarkBook({super.key});

  @override
  State<BarkBook> createState() => _BarkBookState();
}

class _BarkBookState extends State<BarkBook> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int pageIndex = 2;

  final pages = [
    Container(color: Colors.yellow,),
    Container(color: Colors.orangeAccent,),
    ProfilePage(),
  ];

  void showMenu() => _scaffoldKey.currentState!.openEndDrawer();

  void refresh() => setState(() { });

  Future<void> signOut() async => auth.signOut();

  Widget actionButton(onTap, icon, {circled = true}) => Padding(
    padding: EdgeInsets.all(2.5),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: !circled ? null : BoxDecoration(
          shape: BoxShape.circle,
          color: textColor.withOpacity(0.9),
        ),
        padding: EdgeInsets.all(5),
        child: Icon(
          icon,
          size: 28,
          color: circled ? primaryColor : textColor,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {

    void viewSettings() {
      showDialog(
        context: context, 
        builder: (context) => Dialog(
          child: UserForm()
        )
      );
    }

    BoneButton boneButton(label, onTap) => BoneButton(
      label,
      onTap: onTap,
      width: 120,
      height: 30,
    );

    return Container(
      color: primaryColor,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Image.asset(
              "assets/logo/full.png",
              color: textColor,
              scale: 2,
            ),
          ),
          shape: Border(
            bottom: BorderSide(
              color: primaryColorDark,
              width: 5
            )
          ),
          actions: [
            // actionButton(null, Icons.add_a_photo_rounded),
            actionButton(null, Icons.search_rounded),
            actionButton(null, Icons.notifications),
            actionButton(showMenu, Icons.menu, circled: false)
          ],
          backgroundColor: primaryColor,
        ),
        backgroundColor: backgroundColor,
        body: pages[pageIndex],
        endDrawer: Drawer(
          width: screen.size.width/2,
          backgroundColor: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Label(currentUser.username),
              ),
              boneButton("settings", viewSettings),
              boneButton("sign out", signOut),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            pageIndex = index;
            refresh();
          },
          selectedIconTheme: IconThemeData(
              size: 50
          ),
          unselectedIconTheme: IconThemeData(
              size: 35
          ),
          selectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/shapes/dog-house.png')),
                label: "home"
            ),
            BottomNavigationBarItem(
                icon: Icon(null),
                label: pageIndex != 1 ? "bark" : ""
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/shapes/dog-head.png')),
                label: "profile"
            ),
          ],
          elevation: 0,
          backgroundColor: primaryColor,
          selectedItemColor: textColor,
          unselectedItemColor: textColor.withOpacity(0.75),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 5,
                color: primaryColor,
              ),
              color: primaryColor,
            ),
            child: FloatingActionButton(
              onPressed: () {
                pageIndex = 1;
                refresh();
              },
              backgroundColor: textColor.withOpacity(pageIndex == 1 ? 1 : 0.75),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(pageIndex == 1 ? 5 : 10),
                child: Image.asset(
                  'assets/shapes/pawprint.png',
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}