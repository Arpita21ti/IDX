import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(StyleGlobalVariables.screenWidth,
          StyleGlobalVariables.screenSizingReference * 0.15),
      painter: WavePainter(),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    
    Paint paint = Paint()    
      ..shader = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xff9E0000),
      Color(0xffCF1010),
      ],
  ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
  ..style = PaintingStyle.fill;

    Path path = Path();
    // path.lineTo(0, size.height * 0.7); // Starting point (bottom left)
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height * 0.3,
      size.width * 0.6,
      size.height * 0.6,
    ); // Curve 1
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.6,
      size.width,
      size.height * 0.8,
    ); // Curve 2
    path.lineTo(size.width, 0); // Top-right
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No repaint needed for static waves
  }
}
