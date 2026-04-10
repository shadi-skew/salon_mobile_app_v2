import 'package:equatable/equatable.dart';
import 'formula.dart';

/// Represents a step in the formula creation process
class FormulaStep extends Equatable {
  final HairBrand? brand;
  final int? currentHairLevel;
  final int? targetHairLevel;

  const FormulaStep({this.brand, this.currentHairLevel, this.targetHairLevel});

  /// Check if all steps are completed
  bool get isComplete =>
      brand != null && currentHairLevel != null && targetHairLevel != null;

  /// Get progress percentage (0.0 to 1.0)
  double get progress {
    int steps = 0;
    if (brand != null) steps++;
    if (currentHairLevel != null) steps++;
    if (targetHairLevel != null) steps++;
    return steps / 3;
  }

  FormulaStep copyWith({
    HairBrand? brand,
    int? currentHairLevel,
    int? targetHairLevel,
  }) {
    return FormulaStep(
      brand: brand ?? this.brand,
      currentHairLevel: currentHairLevel ?? this.currentHairLevel,
      targetHairLevel: targetHairLevel ?? this.targetHairLevel,
    );
  }

  @override
  List<Object?> get props => [brand, currentHairLevel, targetHairLevel];
}
