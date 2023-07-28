import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services_joined/src/utils/appcolor.dart';

class TeamLogoPainter extends CustomPainter {
 final  String inicialTextTeam;
 final Color colorTeam;

  TeamLogoPainter(this.inicialTextTeam, this.colorTeam);

  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = colorTeam
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;

    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circlePaint);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        
        text: inicialTextTeam,
        style: GoogleFonts.gravitasOne(

          shadows: [
            Shadow(
              color: Colors.white,
              offset: Offset.fromDirection(0,3)
            ),
            Shadow(
                color: inicialTextTeam =="NY" ? AppColors.yankeeblue : Colors.red,
                blurRadius: 2,
                offset: Offset.fromDirection(0,5)
            )
          ],
          // color: Colors.white,
          fontSize: radius,
          fontWeight: FontWeight.bold,

        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final Offset textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}