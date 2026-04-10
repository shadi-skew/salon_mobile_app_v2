import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';

/// Circular progress ring with a centred time readout.
///
/// [progress] runs from 0.0 (full time remaining) to 1.0 (complete).
/// [remainingLabel] and [totalLabel] are pre-formatted "MM:SS" strings.
class CircularTimerWidget extends StatelessWidget {
  const CircularTimerWidget({
    super.key,
    required this.progress,
    required this.remainingLabel,
    required this.totalLabel,
    this.size = 220,
  });

  final double progress;
  final String remainingLabel;
  final String totalLabel;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _TimerPainter(progress: progress),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                remainingLabel,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blackTitle,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'of $totalLabel',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  const _TimerPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 10.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;

    // Grey track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = ColorManager.shimmerGrey
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Teal arc — sweeps clockwise from the top
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        Paint()
          ..color = ColorManager.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_TimerPainter old) => old.progress != progress;
}
