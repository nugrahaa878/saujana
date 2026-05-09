import 'dart:math';
import 'package:flutter/material.dart';
import 'package:saujana/core/theme/app_colors.dart';

/// Saujana brand logo.
///
/// Three concentric rising arcs — representing a horizon expanding outward,
/// reflecting the name "Saujana" (Malay/Indonesian: as far as the eye can see).
class SaujanaLogo extends StatelessWidget {
  const SaujanaLogo({super.key, this.size = 80});

  final double size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkActionSubtle : AppColors.actionSubtle;

    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color:        bgColor,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: CustomPaint(
        painter: _HorizonPainter(isDark: isDark),
      ),
    );
  }
}

class _HorizonPainter extends CustomPainter {
  const _HorizonPainter({required this.isDark});
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final color  = isDark ? AppColors.darkActionDefault : AppColors.actionDefault;
    final cx     = size.width  / 2;
    final cy     = size.height * 0.68; // anchor point slightly below center
    final unit   = size.width  * 0.1;  // base radius unit

    final arcs = [
      (radius: unit * 1.6, opacity: 1.0,  width: unit * 0.55),
      (radius: unit * 2.5, opacity: 0.55, width: unit * 0.45),
      (radius: unit * 3.4, opacity: 0.25, width: unit * 0.35),
    ];

    for (final arc in arcs) {
      final paint = Paint()
        ..color       = color.withValues(alpha: arc.opacity)
        ..style       = PaintingStyle.stroke
        ..strokeWidth = arc.width
        ..strokeCap   = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(cx, cy),
          width:  arc.radius * 2,
          height: arc.radius * 2,
        ),
        pi,      // start at the left (9 o'clock)
        -pi,     // sweep counter-clockwise to the right (upper semicircle)
        false,
        paint,
      );
    }

    // Small filled circle at the anchor point — the "origin" of the view
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), unit * 0.3, dotPaint);
  }

  @override
  bool shouldRepaint(_HorizonPainter old) => old.isDark != isDark;
}
