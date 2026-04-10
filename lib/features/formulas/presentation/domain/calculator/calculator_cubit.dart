import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';

part 'calculator_state.dart';

/// Cubit for managing the multi-step formula calculator workflow
class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorState());

  void selectBrand(HairBrand brand) {
    emit(state.copyWith(selectedBrand: brand));
  }

  void selectCurrentLevel(int level) {
    emit(state.copyWith(currentLevel: level));
  }

  void selectTargetLevel(int level) {
    emit(state.copyWith(targetLevel: level));
  }

  void setFormulaName(String name) {
    emit(state.copyWith(formulaName: name));
  }

  void reset() {
    emit(const CalculatorState());
  }
}
