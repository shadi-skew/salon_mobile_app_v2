import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';

class FormulaState {
  const FormulaState({
    this.allFormulas = const [],
    this.displayedFormulas = const [],
    this.activeFilter = FormulaFilter.all,
    this.searchQuery = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Formula> allFormulas;

  /// Formulas after filter + search have been applied
  final List<Formula> displayedFormulas;

  final FormulaFilter activeFilter;
  final String searchQuery;
  final bool isLoading;
  final String? errorMessage;

  FormulaState copyWith({
    List<Formula>? allFormulas,
    List<Formula>? displayedFormulas,
    FormulaFilter? activeFilter,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FormulaState(
      allFormulas: allFormulas ?? this.allFormulas,
      displayedFormulas: displayedFormulas ?? this.displayedFormulas,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
