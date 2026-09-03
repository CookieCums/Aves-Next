import 'package:aves/model/settings/settings.dart';
import 'package:aves/widgets/common/fx/borders.dart';
import 'package:aves/widgets/common/fx/colors.dart';
import 'package:aves_model/aves_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvesLogo extends StatelessWidget {
  final double size;

  const AvesLogo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = CustomPaint(
      size: Size(size / 1.4, size / 1.4),
      painter: AvesLogoPainter(),
    );
    if (context.select<Settings, bool>((v) => v.themeColorMode == AvesThemeColorMode.monochrome)) {
      final tint = Color.lerp(theme.colorScheme.primary, Colors.white, .5)!;
      child = ColorFiltered(
        colorFilter: ColorFilter.mode(tint, BlendMode.modulate),
        child: ColorFiltered(
          colorFilter: MatrixColorFilters.greyscale,
          child: child,
        ),
      );
    }

    return CircleAvatar(
      backgroundColor: theme.dividerColor,
      radius: size / 2,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: size / 2 - AvesBorder.curvedBorderWidth(context),
        child: child,
      ),
    );
  }
}

class AvesLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 512;

    Path transformPath(List<Offset> points) {
      final path = Path();
      path.moveTo(points.first.dx * scale, points.first.dy * scale);
      for (final point in points.skip(1)) {
        path.lineTo(point.dx * scale, point.dy * scale);
      }
      path.close();
      return path;
    }

    final backWing = transformPath(const [
      Offset(210, 190),
      Offset(120, 110),
      Offset(150, 170),
      Offset(180, 210),
      Offset(210, 210),
    ]);

    final body = Path()
      ..moveTo(170 * scale, 290 * scale)
      ..cubicTo(
        200 * scale,
        320 * scale,
        270 * scale,
        300 * scale,
        320 * scale,
        240 * scale,
      )
      ..lineTo(410 * scale, 210 * scale)
      ..lineTo(330 * scale, 230 * scale)
      ..cubicTo(
        300 * scale,
        190 * scale,
        240 * scale,
        190 * scale,
        200 * scale,
        230 * scale,
      )
      ..close();

    final topWing = Path()
      ..moveTo(220 * scale, 220 * scale)
      ..lineTo(160 * scale, 80 * scale)
      ..cubicTo(
        210 * scale,
        130 * scale,
        250 * scale,
        180 * scale,
        270 * scale,
        220 * scale,
      )
      ..close();

    final bodyPaint = Paint()..color = const Color(0xff5b6bf5);
    final backWingPaint = Paint()
      ..color = const Color(0xff7c8cf8).withValues(alpha: .5);
    final topWingPaint = Paint()
      ..color = Colors.white.withValues(alpha: .75);
    final sparkPaint = Paint()..color = Colors.white;

    canvas.drawPath(backWing, backWingPaint);
    canvas.drawPath(body, bodyPaint);
    canvas.drawPath(topWing, topWingPaint);
    canvas.drawCircle(
      Offset(320 * scale, 230 * scale),
      6 * scale,
      sparkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
