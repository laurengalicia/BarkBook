import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Label extends StatelessWidget {
  final String text;
  const Label(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.75)),
          bottom: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 0.25,
            color: Colors.black.withOpacity(0.5)
          )
        ],
        color: Colors.black
      ),
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.specialElite(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 1,
              left: 1,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.specialElite(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.white.withAlpha(100),
              ),
            ),
          ),
          // textDisplay(Colors.white),
        ],
      ),
    );
  }
}
