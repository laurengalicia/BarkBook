import 'package:flutter/material.dart';

import 'globals/variables.dart';

class Folder extends StatelessWidget {
  final Widget? child;
  final String title;
  final Color titleColor;
  final Color backgroundColor;

  const Folder(
    {
      Key? key,
      required this.title,
      required this.titleColor,
      required this.backgroundColor,
      this.child,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget tab() {
      double edgeWidth = 10;
      return CustomPaint(
        painter: FolderTabPainter(
          edgeWidth: edgeWidth,
          length: MediaQuery.of(context).size.width,
          color: backgroundColor
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: edgeWidth*2),
          height: 35,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
        ),
      );
    }

    return Container(
      child: Stack(
        children: [
          // Row(
          //   children: [
          //     tab(),
          //   ],
          // ),
          // tab(),
          Padding(
            padding: EdgeInsets.only(top: 35),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(75),
                    offset: Offset(4, -4),
                    blurRadius: 2
                  )
                ],
                color: backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: child,
              ),
            ),
          ),
          tab(),
        ],
      ),
    );
  }
}

class FolderTabPainter extends CustomPainter {
  final double edgeWidth;
  final double length;
  final Color color;

  FolderTabPainter(
    {
      required this.edgeWidth,
      required this.length,
      required this.color
    }
  );

  double sigma( double radius ) {
    return radius * 0.5 + 0.5;
  }

  @override
  void paint( Canvas canvas, Size size ) {

    Path path = Path()
    ..moveTo(0,size.height)
    ..lineTo(edgeWidth,0)
    ..lineTo(size.width-edgeWidth,0)
    ..lineTo(size.width,size.height)
    ..close();

    Paint shadow = Paint()
      ..color = Colors.black.withAlpha(75)
      ..maskFilter = MaskFilter.blur( BlurStyle.normal, sigma(3) );

    canvas.drawPath( Path()..addPath(path, Offset(4, -4)), shadow );

    canvas.drawPath( path, Paint()..color = color );
  }

  @override
  bool shouldRepaint( CustomPainter oldDelegate ) => false;
}