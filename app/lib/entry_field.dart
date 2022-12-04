import 'package:flutter/material.dart';

import 'globals/colors.dart';
import 'globals/functions.dart';
import 'globals/variables.dart';

class EntryField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final int minLength;
  final int? maxLength;
  final int? exactLength;
  final String? pattern;
  final String? invalidCharacters;
  final void Function(String)? onChanged;
  final void Function(dynamic?)? onSaved;
  final String? errorText;
  final bool obscureText;
  final bool autocorrect;
  final double? width;
  final bool? enabled;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool autovalidate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool spaceUnder;

  final bool underlined;
  final bool filled;
  
  final Color? color;

  const EntryField(
      this.label,
      {
        Key? key,
        this.controller,
        this.focusNode,
        this.keyboardType,
        this.textCapitalization = TextCapitalization.none,
        this.textInputAction,
        this.style,
        this.strutStyle,
        this.onTap,
        this.onEditingComplete,
        this.onFieldSubmitted,
        this.onSaved,
        this.initialValue,
        this.minLength = 0,
        this.maxLength,
        this.exactLength,
        this.pattern,
        this.invalidCharacters,
        this.onChanged,
        this.errorText,
        this.obscureText = false,
        this.autocorrect = false,
        this.underlined = false,
        this.filled = false,
        this.width,
        this.validator,
        this.autovalidate = false,
        this.enabled,
        this.readOnly = false,
        this.prefixIcon,
        this.suffixIcon,
        this.spaceUnder = true,
        this.color,
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("Entry field: $label");

    Color fieldColor = color ?? textColor;

    InputBorder border(color) {
      BorderSide borderSide = BorderSide(color: color, width: 2.5);
      return underlined
          ? UnderlineInputBorder(
          borderSide: borderSide
      )
          : OutlineInputBorder(
          borderSide: filled ? BorderSide.none : borderSide,
          borderRadius: BorderRadius.circular(25)
      );
    }

    InputDecoration decoration = InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      counterText: "",
      filled: filled,
      fillColor: fieldColor.withOpacity(0.75),
      border: border(fieldColor),
      enabledBorder: border(fieldColor.withOpacity(0.75)),
      focusedBorder: border(fieldColor),
      errorBorder: border(fieldColor.withOpacity(0.5)),
      focusedErrorBorder: border(fieldColor.withOpacity(0.75)),
      labelText: label,
      labelStyle: TextStyle(
          color: fieldColor.withOpacity(0.6)
      ),
      floatingLabelStyle: TextStyle(
          color: fieldColor.withOpacity(0.85),
          height: 1
      ),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      errorText: errorText,
      errorStyle: TextStyle(
        fontSize: relativeSize(0.035),
        color: fieldColor.withOpacity(.85),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        width: width ?? relativeSize(0.7),
        height: spaceUnder ? relativeSize(0.25) : null,
        child: TextFormField(
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          decoration: decoration,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          style: style ?? TextStyle(
            color: fieldColor,
            fontSize: relativeSize(0.06),
          ),
          strutStyle: strutStyle,
          textAlign: TextAlign.center,
          obscureText: obscureText,
          autocorrect: autocorrect,
          readOnly: readOnly,
          enabled: enabled,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          cursorWidth: 5,
          cursorRadius: Radius.circular(25),
          maxLength: maxLength,
          validator: validator ?? ( (value) {
            if(exactLength != null && value?.trim().length != exactLength) {
              return "must be $exactLength character${exactLength! > 1 ? "s" : ""}";
            }
            if(value == null || value.trim().length < minLength) {
              return "at least $minLength character${minLength > 1 ? "s" : ""}";
            }
            if(pattern != null && !RegExp(pattern!).hasMatch(value)) {
              return "invalid character";
            }
            if(invalidCharacters != null && RegExp(invalidCharacters!).hasMatch(value)) {
              return "invalid character";
            }
            return null;
          }),
          autovalidateMode: autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          onChanged: onChanged,
          cursorColor: fieldColor,
        ),
      ),
    );
  }
}