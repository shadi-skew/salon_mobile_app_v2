import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/timer_session.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/timer/timer_cubit.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/timer/timer_state.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/chair_info_card.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/circular_timer_widget.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/processing_notes_card.dart';

/// Full-screen timer page for an active formula processing session.
///
/// Receives a [TimerSession] via the constructor (passed from
/// [FormulaResultsPage]).  Creates its own [TimerCubit] so the countdown
/// continues independently of the parent widget tree.
class TimerDetailPage extends StatelessWidget {
  const TimerDetailPage({super.key, required this.session});

  static const String routeName = '/formulas/timer';

  final TimerSession session;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerCubit(session),
      child: const _TimerDetailView(),
    );
  }
}

// ---------------------------------------------------------------------------
// View — reads from BlocBuilder so every tick re-renders efficiently
// ---------------------------------------------------------------------------

class _TimerDetailView extends StatelessWidget {
  const _TimerDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCubit, TimerState>(
      listenWhen: (prev, curr) => !prev.isCompleted && curr.isCompleted,
      listener: (context, state) => _showCompletionDialog(context),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.lightGrey,
          appBar: _buildAppBar(context, state),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              children: [
                ChairInfoCard(session: state.session),
                const SizedBox(height: 32),
                CircularTimerWidget(
                  progress: state.progress,
                  remainingLabel: state.remainingLabel,
                  totalLabel: state.totalLabel,
                ),
                const SizedBox(height: 32),
                _TimerControlsRow(state: state),
                if (state.session.notes.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  ProcessingNotesCard(notes: state.session.notes),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, TimerState state) {
    return AppBar(
      backgroundColor: ColorManager.lightGrey,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: ColorManager.blackTitle,
          size: 20,
        ),
        onPressed: () {
          context.read<TimerCubit>().stopTimer();
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Timers',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: ColorManager.blackTitle,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: ColorManager.yellow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'Level ${state.session.targetLevel}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorManager.blackGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Processing Complete!',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'The formula processing time has finished. Please check on your client.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // close timer page
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: ColorManager.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Timer controls row — pause/resume + stop
// ---------------------------------------------------------------------------

class _TimerControlsRow extends StatelessWidget {
  const _TimerControlsRow({required this.state});

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: state.isCompleted
                ? null
                : () {
                    state.isPaused
                        ? context.read<TimerCubit>().resumeTimer()
                        : context.read<TimerCubit>().pauseTimer();
                  },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: state.isCompleted
                    ? Colors.grey.shade300
                    : ColorManager.green,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state.isPaused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    color: ColorManager.white,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.isPaused ? 'Resume' : 'Pause',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Stop button
        GestureDetector(
          onTap: () {
            context.read<TimerCubit>().stopTimer();
            Navigator.pop(context);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Icon(
              Icons.stop_rounded,
              color: ColorManager.darkOrange,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
