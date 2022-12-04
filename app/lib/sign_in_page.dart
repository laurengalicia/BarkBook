import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bone_button.dart';
import 'globals/colors.dart';
import 'entry_field.dart';
import 'entry_fields.dart';
import 'globals/functions.dart';
import 'globals/variables.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  // Widget build(BuildContext context) => Material(
  //   color: Colors.cyan,
  //   child: SafeArea(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         header(),
  //         form(),
  //         footer(),
  //       ],
  //     ),
  //   ),
  // );

  Widget build(BuildContext context) {
    print(currentUser.zipCode);
    print("_isAccountInfoForm: $_isAccountInfoForm");
    return Material(
      color: Colors.cyan,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            header(),
            form(),
            footer(),
          ],
        ),
      ),
    );
  }

  bool _isAccountInfoForm = true;
  bool _isSignInPage      = true;

  final _formKeyUserInfo    = GlobalKey<FormState>();
  final _formKeyAccountInfo = GlobalKey<FormState>();

  String _password = "";

  String? _errorMessageEmail;
  String? _errorMessagePassword;

  Widget emailField() => EntryField(
    'email${_isSignInPage ? " or username" : ""}',
    initialValue: currentUser.email,
    errorText: _errorMessageEmail,
    invalidCharacters: '[^A-Za-z0-9_@.-]',
    minLength: 3,
    onSaved: (value) {
      currentUser.email = value.trim().toLowerCase();
    },
  );

  Widget passwordField() => EntryField(
    'password',
    obscureText: true,
    minLength: 6,
    errorText: _errorMessagePassword,
    invalidCharacters: '[^A-Za-z0-9$symbols]',
    onSaved: (value) {
      _password = value;
    },
  );

  Widget logo() => Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 3,
          left: 3,
        ),
        child: Image.asset(
          "assets/logo/full.png",
          color: Colors.black.withAlpha(50),
          width: 275,
          height: 75,
          // scale: 2,
        ),
      ),
      Image.asset(
        "assets/logo/full.png",
        color: textColor,
        width: 275,
        height: 75,
        // scale: 2,
      ),
    ],
  );

  Widget pageToggle() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "${_isAccountInfoForm && _isSignInPage ? "new" : "existing"} user?",
        style: textTheme.subtitle1,
      ),
      TextButton(
          onPressed: () {
            _formKeyUserInfo.currentState?.save();
            _formKeyAccountInfo.currentState?.save();
            if(_isSignInPage) {
              _isSignInPage = false;
              _isAccountInfoForm = false;
            }
            else {
              _isSignInPage = true;
              _isAccountInfoForm = true;
            }
            _errorMessageEmail = null;
            _errorMessagePassword = null;
            refresh();
          },
          child: Text(
            "sign ${_isAccountInfoForm && _isSignInPage ? "up" : "in"} here!",
            style: textTheme.subtitle2,
          )
      ),
    ],
  );

  Widget header() => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        width: 275,
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _isSignInPage ? 0 : 1,
              child: _isSignInPage ? Container() : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2,
                                  color: Colors.white
                              )
                          )
                      ),
                      child: Text(
                        "${_isAccountInfoForm ? "Account" : "User"} Info".toUpperCase(),
                        style: textTheme.headline1,
                      )
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "step ${_isAccountInfoForm ? "2" : "1"} of 2".toLowerCase(),
                        style: textTheme.headline2,
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              bottom: _isSignInPage ? 0 : 60,
              child: logo(),
              // bottom: _isSignInPage ? 10 : 5,
            )
          ],
        ),
      ),
    ),
  );

  Widget footer() => Expanded(
    child: Container(
      width: 275,
      child: Column(
        children: [
          BoneButton(
            "sign ${_isSignInPage ? "in" : "up"}",
            width: relativeSize(0.45),
            onTap: () {
              _errorMessageEmail = null;
              _errorMessagePassword = null;
              refresh();
              _isSignInPage ? signIn() : signUp();
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: pageToggle(),
          )
        ],
      )
    ),
  );

  Widget form() => Form(
    key: _isAccountInfoForm ? _formKeyAccountInfo : _formKeyUserInfo,
    child: Column(
      children: [
        _isAccountInfoForm
            ? emailField()
            : birthDateField(onSaved: (entry) => currentUser.birthDate = entry),
        _isAccountInfoForm
            ?  passwordField()
            : zipCodeField(onSaved: (entry) => currentUser.zipCode = entry),
      ],
    ),
  );

  void refresh() => setState(() { });

  void signIn() {
    print("signIn");
    if( _formKeyAccountInfo.currentState!.validate() ) {
      _formKeyAccountInfo.currentState!.save();
      refresh();
      validateEmail();
    }
  }

  Future<void> validateEmail() async {
    if (!currentUser.email.contains('@')) {
      await firestore
          .collection('users')
          .where("username", isEqualTo: currentUser.email.toUpperCase())
          .get()
          .then((event) {
        if (event.docs.isEmpty) {
          setState(() {
            _errorMessageEmail = "no account has that username.";
            currentUser.email = "";
          });
          return;
        } else {
          currentUser.email = event.docs.first.data()['email'];
        }
      });
    }
    if(currentUser.email != "") {
      try {
        await auth.signInWithEmailAndPassword(
          email: currentUser.email,
          password: _password,
        );
        // currentUser = BarkBookUser.fromDoc( await currentUserDoc().get() );
      } on FirebaseAuthException catch (error) {
        setState(() {
          ifErrorMessage(error.message!);
          if (error.message!.contains("no user")) {
            _errorMessageEmail = "no account has that email address.";
          }
        });
      }
    }
  }

  void signUp() {
    if(!_isSignInPage && !_isAccountInfoForm) {
      if( _formKeyUserInfo.currentState!.validate() ) {
        _formKeyUserInfo.currentState!.save();
        refresh();
        validateZipCode(
          currentUser.zipCode,
          onValidated: () {
            _isAccountInfoForm = true;
            refresh();
          },
        );
        refresh();
      }
    }
    else {
      if(_formKeyAccountInfo.currentState!.validate() ) {
        _formKeyAccountInfo.currentState!.save();
        refresh();
        signUpEmail();
      }
    }
  }
  Future<void> signUpEmail() async {
    await createUsername();
    try {
      await auth.createUserWithEmailAndPassword(
        email: currentUser.email,
        password: _password,
      );
    } on FirebaseAuthException catch (error) {
      ifErrorMessage(error.message!);
      if(error.message!.contains("already in use")) {
        _errorMessageEmail = '${error.message!.split(" by")[0]}.'.toLowerCase();
      }
      refresh();
    }
  }

  Future<void> createUsername() async {
    QuerySnapshot<Map<String, dynamic>> query = await users.get();
    currentUser.username = "BARKER-${query.size.toString().padLeft(4, "0")}";
  }



  void ifErrorMessage(String error) {
    error = error.toLowerCase();
    print("ifErrorMessage");
    print(error);
    if(error.contains("password")) {
      _errorMessagePassword = error;
    } else {
      _errorMessageEmail = _errorMessageEmail ?? error;
    }
    print(_errorMessageEmail);
    print(_errorMessagePassword);
  }
}