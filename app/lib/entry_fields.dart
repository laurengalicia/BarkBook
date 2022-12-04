import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'date_picker.dart';
import 'entry_field.dart';
import 'globals/variables.dart';

String? _errorTextZipCode;

Widget birthDateField({onSaved}) => DatePicker(
  label: "date of birth",
  initialValue: currentUser.birthDate,
  ageLimit: 13,
  onSaved: onSaved,
  onFieldSubmitted: onSaved,
);

Widget zipCodeField({onSaved}) {
  print("zipCodeField");
  print(_errorTextZipCode);
  return EntryField(
    "zip code",
    initialValue: currentUser.zipCode,
    keyboardType: TextInputType.number,
    invalidCharacters: '[^0-9]',
    exactLength: 5,
    autovalidate: true,
    errorText: _errorTextZipCode,
    onSaved: onSaved,
    onFieldSubmitted: onSaved,
  );
}

Future<void> validateZipCode(String zipCode, {required Function onValidated, Function? onInvalidated}) async {
  http.get(Uri.parse("https://laurengalicia.github.io/data/NYC_Zip_Codes.json")).then( (value) {
    Map body = jsonDecode(value.body);
    Iterable zipCodes = body.keys;
    print("validating");
    if(zipCodes.contains(zipCode)) {
      _errorTextZipCode = "";
      onValidated();
      print("validated");
    }
    else {
      _errorTextZipCode = "you must be a resident of NYC.";
      if(onInvalidated != null) {
        onInvalidated();
      }
    }
  });
}