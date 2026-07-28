import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Figma card-corner hex decoration: flat-top hexes with white gutters,
/// clipped flush to the card's top edge and 12px top-right radius.
class CardHexAccent extends StatelessWidget {
  const CardHexAccent({super.key});

  static const double top = 0;
  static const double right = 0;
  static const double width = 50;
  static const double height = 47;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _HexCornerPainter()),
    );
  }
}

class _HexCornerPainter extends CustomPainter {
  const _HexCornerPainter();

  static const double _w = 34;
  static const double _gap = 2.2;
  static const double _radius = 12;

  static double get _h => _w * math.sqrt(3) / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final h = _h;
    final dx = _w * 0.75 + _gap;
    final dyN = h + _gap;
    final dyNe = h * 0.5 + _gap * 0.5;

    // Local hex centers before shifting into the clipped view.
    final lightCx = _w / 2;
    final lightCy = h / 2;
    final northCx = lightCx;
    final northCy = lightCy - dyN;
    final neCx = lightCx + dx;
    final neCy = lightCy - dyNe;

    // Shift so the card top cuts through the north hex midline and the
    // right edge cuts through the NE hex (small rounded corner piece).
    final originX = lightCx - _w / 2;
    final originY = northCy;
    final clipW = (neCx + _w * 0.15) - originX;

    Offset map(double cx, double cy) => Offset(cx - originX, cy - originY);

    canvas.save();
    canvas.clipPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(clipW - _radius, 0)
        ..arcToPoint(
          Offset(clipW, _radius),
          radius: const Radius.circular(_radius),
        )
        ..lineTo(clipW, size.height)
        ..lineTo(0, size.height)
        ..close(),
    );

    final dark = Paint()
      ..color = AppColors.primary
      ..isAntiAlias = true;
    final light = Paint()
      ..color = const Color(0xFFCDBCE3)
      ..isAntiAlias = true;

    canvas.drawPath(_flatTopHex(map(lightCx, lightCy)), light);
    canvas.drawPath(_flatTopHex(map(northCx, northCy)), dark);
    canvas.drawPath(_flatTopHex(map(neCx, neCy)), dark);
    canvas.restore();
  }

  Path _flatTopHex(Offset c) {
    const w = _w;
    final h = _h;
    return Path()
      ..moveTo(c.dx - w * 0.25, c.dy - h / 2)
      ..lineTo(c.dx + w * 0.25, c.dy - h / 2)
      ..lineTo(c.dx + w / 2, c.dy)
      ..lineTo(c.dx + w * 0.25, c.dy + h / 2)
      ..lineTo(c.dx - w * 0.25, c.dy + h / 2)
      ..lineTo(c.dx - w / 2, c.dy)
      ..close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
