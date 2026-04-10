import 'package:salon_mobile_app_v2/features/formulas/domain/entities/timer_session.dart';

/// Immutable state for [TimerCubit].
class TimerState {
  const TimerState({
    required this.session,
    required this.remainingSeconds,
    this.isPaused = false,
    this.isCompleted = false,
  });

  final TimerSession session;
  final int remainingSeconds;
  final bool isPaused;
  final bool isCompleted;

  /// Progress from 0.0 (not started) to 1.0 (complete).
  double get progress =>
      1.0 - (remainingSeconds / session.totalSeconds).clamp(0.0, 1.0);

  /// MM:SS label for the remaining time.
  String get remainingLabel {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  /// MM:SS label for the total duration.
  String get totalLabel {
    final m = session.totalSeconds ~/ 60;
    final s = session.totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  TimerState copyWith({
    TimerSession? session,
    int? remainingSeconds,
    bool? isPaused,
    bool? isCompleted,
  }) {
    return TimerState(
      session: session ?? this.session,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isPaused: isPaused ?? this.isPaused,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
