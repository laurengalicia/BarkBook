import 'package:flutter/material.dart';

class BoneButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool shadowed;

  BoneButton(
      this.label,
      {
        Key? key,
        this.onTap,
        this.width,
        this.height,
        this.fontSize,
        this.shadowed = true,
      }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
            alignment: Alignment.center,
            children: [
              body(shadow: boxShadow),
              end(left: width ?? 100),
              end(right: width ?? 100),
              body(shadow: null),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize ?? (height ?? 35) * 0.65,
                    letterSpacing: 1,
                    fontFamily: 'Futura',
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }

  List<BoxShadow> boxShadow = [
    BoxShadow(
      // color: Colors.black.withOpacity(isLightMode ? 0.25 : 0.40),
      color: Colors.black.withAlpha(50),
      offset: const Offset(3, 3),
      blurRadius: 0.25,
      spreadRadius: 0.25,
    )
  ];


  Widget body({shadow}) {
    return Container(
      width: width ?? 100,
      height: height ?? 35,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: shadowed ? shadow : null,
      ),
    );
  }

  Widget end({double left: 0, double right: 0}) {
    Widget corner() {
      return SizedBox.square(
        dimension: (height ?? 35) * 1.25,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: shadowed ? boxShadow : null,
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
      ),
      child: Stack(
        children: [
          corner(),
          Padding(
            padding: EdgeInsets.only(top: (height ?? 35) * .75),
            child: corner(),
          ),
        ],
      ),
    );
  }
}
