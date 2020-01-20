import 'dart:math';

import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  final hourTickMarkLength = 12.0;
  final minuteTickMarkLength = 6.0;

  final hourTickMarkWidth = 9.0;
  final minuteTickMarkWidth = 6.0;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  ClockDialPainter()
      : tickPaint = new Paint(),
        textPainter = new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = const TextStyle(
          color: Color(0xFF651e3e),
          fontFamily: 'Prata',
          fontSize: 25.0, //15
        ) {
    tickPaint.color = Color(0xFF651e3e);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.shortestSide / 2;
    canvas.save();

    // Sets the position of the canvas to the center of the layout
    canvas.translate(size.width / 2, size.height / 2);
    for (var i = 0; i < 60; i++) {
      //Decides when to  make the length and stroke of the tick marker,
      // longer and thicker depending on its position on the clock.
      tickMarkLength = i % 5 == 0 ? hourTickMarkLength : minuteTickMarkLength;
      tickPaint.strokeWidth =
          i % 5 == 0 ? hourTickMarkWidth : minuteTickMarkWidth;
      canvas.drawLine(new Offset(0.0, -radius),
          new Offset(0.0, -radius + tickMarkLength), tickPaint);

      //draw the text
      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0.0, -radius + 20.0);

        textPainter.text = new TextSpan(
          // text: '${i == 0 ? 12 : i ~/ 5}',
          style: textStyle,
        );

        //helps make the text painted vertically
        canvas.rotate(-angle * i);

        textPainter.layout();

        textPainter.paint(canvas,
            new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

        canvas.restore();
      }
      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //We have no reason to repaint so we return false.
    return false;
  }
}
