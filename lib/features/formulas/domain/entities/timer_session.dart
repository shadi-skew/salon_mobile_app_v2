/// Represents an active formula processing session passed to [TimerDetailPage].
class TimerSession {
  const TimerSession({
    required this.id,
    required this.chairNumber,
    required this.clientName,
    required this.serviceType,
    required this.totalSeconds,
    required this.targetLevel,
    this.notes = const [],
  });

  final String id;
  final int chairNumber;
  final String clientName;
  final String serviceType;

  /// Total processing duration in seconds (e.g. 1800 for 30:00)
  final int totalSeconds;

  /// Target hair level shown in the AppBar badge
  final int targetLevel;

  /// Step-by-step processing instructions shown in the notes card
  final List<String> notes;
}
