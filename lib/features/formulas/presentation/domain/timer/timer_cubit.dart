import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/timer_session.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/timer/timer_state.dart';

/// Manages countdown timer for an active formula processing session.
///
/// Uses a [Stream.periodic] subscription so it can be cleanly cancelled on
/// pause/stop/close without leaking resources.
class TimerCubit extends Cubit<TimerState> {
  TimerCubit(TimerSession session)
    : super(
        TimerState(session: session, remainingSeconds: session.totalSeconds),
      ) {
    _startTick();
  }

  StreamSubscription<int>? _subscription;

  void _startTick() {
    _subscription = Stream.periodic(
      const Duration(seconds: 1),
      (i) => i,
    ).listen((_) => _tick());
  }

  void _tick() {
    if (state.remainingSeconds <= 0) {
      _subscription?.cancel();
      _subscription = null;
      emit(state.copyWith(remainingSeconds: 0, isCompleted: true));
      return;
    }
    emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
  }

  /// Pauses the countdown. Safe to call when already paused.
  void pauseTimer() {
    if (state.isPaused) return;
    _subscription?.cancel();
    _subscription = null;
    emit(state.copyWith(isPaused: true));
  }

  /// Resumes the countdown. Safe to call when already running.
  void resumeTimer() {
    if (!state.isPaused || state.isCompleted) return;
    emit(state.copyWith(isPaused: false));
    _startTick();
  }

  /// Cancels the subscription without emitting — caller is responsible for
  /// popping the route.
  void stopTimer() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
