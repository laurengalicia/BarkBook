import 'dart:convert';
import 'globals/colors.dart';
import 'entry_field.dart';
import 'package:http/http.dart' as http;
import 'package:substring_highlight/substring_highlight.dart';

import 'globals/functions.dart';
import 'globals/variables.dart';
import 'package:flutter/material.dart';

class BreedDropDown extends StatefulWidget {
  final String initialValue;
  final Function(String) onSaved;
  final bool autovalidate;
  final String errorText;
  BreedDropDown({Key? key, required this.initialValue, required this.onSaved, required this.autovalidate, required this.errorText}) : super(key: key);

  @override
  _BreedDropDownState createState() => _BreedDropDownState();
}

class _BreedDropDownState extends State<BreedDropDown> {

  TextEditingController _controller = TextEditingController();

  FocusNode _focusNode = FocusNode();

  String errorText = "";

  bool showError = false;

  Widget build(BuildContext context) {

    return FutureBuilder(
        future: http.get(Uri.parse("https://aala76.github.io/Dog_Data/dog_data.json")),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var result = snapshot.requireData;

            Map breedData = jsonDecode(result.body);

            breeds = breedData.keys.map((key) => key.toString()).toList();

            return Autocomplete(
                optionsBuilder: (textEditingValue) {
                  if (_controller.text == widget.initialValue) {
                    return const Iterable<String>.empty();
                  } else {
                    return breeds.where((substring) => substring.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  }
                },
                optionsViewBuilder: (context, onSelected, options) => Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 5,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 200,
                      ),
                      child: Container(
                        width: relativeSize(0.7),
                        color: primaryColor,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final String option = options.elementAt(index).toString();
                            return ListTile(
                              onTap: () {
                                _controller.text = option;
                                onSelected(option);
                              },
                              title: SubstringHighlight(
                                text: option,
                                term: _controller.text,
                                textStyle: TextStyle(color: primaryColor, fontSize: 18),
                                textStyleHighlight: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  _controller = controller;
                  _focusNode = focusNode;
                  return EntryField(
                    "breed",
                    prefixIcon: Icon(Icons.search_rounded, color: primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear_rounded, color: primaryColor),
                      padding: EdgeInsets.zero,
                      onPressed: () { _controller.text = ""; },
                    ),
                    controller: controller..text = widget.initialValue,
                    focusNode: _focusNode,
                    onEditingComplete: onEditingComplete,
                    onSaved: (value) {
                      showError = true;
                      widget.onSaved(value);
                      _focusNode.unfocus();
                    },
                    onTap: () {
                      if(showError) {
                        _controller.text = "";
                        showError = false;
                      }
                    },
                    onChanged: (value) {
                      _controller.value = _controller.value.copyWith(text: value, selection: TextSelection.collapsed(offset: value.length));
                    },
                    minLength: 3,
                    autovalidate: widget.autovalidate,
                    spaceUnder: false,
                    errorText: _controller.text == "" || _controller.text == widget.initialValue ? null : widget.errorText,
                  );
                }
            );
          }
          return Text("Loading");
        }
    );
  }
}