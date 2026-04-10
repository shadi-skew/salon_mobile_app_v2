part of 'calculator_cubit.dart';

/// State for the formula calculator
class CalculatorState {
  const CalculatorState({
    this.selectedBrand,
    this.currentLevel,
    this.targetLevel,
    this.formulaName = '',
  });

  final HairBrand? selectedBrand;
  final int? currentLevel;
  final int? targetLevel;
  final String formulaName;

  bool get canProceedFromBrand => selectedBrand != null;
  bool get canProceedFromCurrentLevel => currentLevel != null;
  bool get canProceedFromTargetLevel => targetLevel != null;
  bool get isComplete =>
      selectedBrand != null && currentLevel != null && targetLevel != null;

  CalculatorState copyWith({
    HairBrand? selectedBrand,
    int? currentLevel,
    int? targetLevel,
    String? formulaName,
  }) {
    return CalculatorState(
      selectedBrand: selectedBrand ?? this.selectedBrand,
      currentLevel: currentLevel ?? this.currentLevel,
      targetLevel: targetLevel ?? this.targetLevel,
      formulaName: formulaName ?? this.formulaName,
    );
  }
}
