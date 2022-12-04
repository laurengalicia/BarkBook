import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals/colors.dart';
import 'globals/variables.dart';

class DogTag extends StatelessWidget {
  const DogTag({Key? key}) : super(key: key);

  Widget data() {

    Widget field(text, {double height = 25, fontWeight, fontStyle}) => Container(
      height: height,
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: Colors.white
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipPath(
            //   clipper: RibbonLabelClipper(edgeWidth: 5),
            //   child: Container(
            //     padding: const EdgeInsets.only(
            //       bottom: 5,
            //       left: 10,
            //       right: 10,
            //     ),
            //     color: Colors.white,
            //     child: Text(
            //       "Montgomery",
            //       style: TextStyle(
            //         fontSize: 30,
            //         color: Colors.deepPurple,
            //       ),
            //     ),
            //   ),
            // ),
            field("Montgomery", height: 50, fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  field("GOLDEN RETRIEVER"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      field("4 years old"),
                      Icon(
                        Icons.male,
                        size: 25,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 4,
        bottom: 4,
      ),
      child: CustomPaint(
        painter: DogTagPainter(
          color: dogTagColor,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 40,
            top: 15,
            right: 20,
            bottom: 15,
          ),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 125,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://thefactualdoggo.com/wp-content/uploads/2022/05/Friendly-Golden-Retriever.jpg'),
                  ),
                ),
              ),
              Expanded(child: data()),
            ],
          ),
        ),
      ),
    );
  }
}


class DogTagPainter extends CustomPainter {
  final MaterialColor color;

  DogTagPainter( {required this.color} );

  double sigma( double radius ) {
    return radius * 0.5 + 0.5;
  }

  @override
  void paint( Canvas canvas, Size size ) {

    LinearGradient gradient =  LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        color.shade400,
        color.shade300,
      ]
    );

    final paint = Paint()
      ..shader = gradient.createShader(
      Rect.fromLTRB( 0, 0, size.width, size.height )
    );

    double holeDistance = 20;
    double holeSize = 10;

    Path hole( Offset holePosition ) => Path()..addOval(
      Rect.fromCircle(
        center: holePosition,
        radius: holeSize,
      )
    );

    Path shape = Path()..addRRect(
      RRect.fromLTRBR( 0, 0, size.width, size.height, Radius.elliptical( 25, 50 ) )
    );

    Path path = Path.combine(
      PathOperation.difference,
      shape,
      hole( Offset( holeDistance, size.height/2 ) )..close(),
    );

    double depth = 5;

    Path edgePath = Path()..addPath( shape, Offset( depth, depth ) );
    edgePath = Path.combine( PathOperation.difference, edgePath, hole( Offset( holeDistance + depth, size.height/2 + depth ) ) );

    Paint shadow = Paint()
      ..color= Colors.black.withAlpha(100)
      ..maskFilter = MaskFilter.blur( BlurStyle.normal, sigma(2) );

    Path shadowPath = Path()..addPath( shape, Offset(depth, depth+4) );
    shadowPath = Path.combine( PathOperation.difference, shadowPath, hole( Offset( holeDistance + depth, size.height/2 + depth+4 ) ) );

    canvas.drawPath( shadowPath, shadow );
    canvas.drawPath( edgePath, Paint()..color = color );
    canvas.drawPath( path, paint );


    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = Colors.white.withAlpha(50);

    canvas.drawPath( path, outline );
  }

  @override
  bool shouldRepaint( CustomPainter oldDelegate ) => false;
}