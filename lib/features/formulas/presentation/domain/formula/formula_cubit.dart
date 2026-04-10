import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/formula/formula_state.dart';

class FormulaCubit extends Cubit<FormulaState> {
  FormulaCubit() : super(const FormulaState(isLoading: true)) {
    _loadFormulas();
  }

  // ---------------------------------------------------------------------------
  // Mock data — replace with repository call when API is ready
  // ---------------------------------------------------------------------------

  static final List<Formula> _mockFormulas = [
    Formula(
      id: '1',
      name: 'Ash Blonde Repair',
      currentLevel: 9,
      targetLevel: 10,
      brand: 'Wella',
      processingTime: '25-30 min',
      isFavorite: true,
      tags: ['Previously Bleached', 'Dry'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Formula(
      id: '2',
      name: 'Golden Chestnut Treatment',
      currentLevel: 6,
      targetLevel: 7,
      brand: 'Pravana',
      processingTime: '30-35 min',
      isFavorite: false,
      tags: ['Naturally Curly', 'Moisturized'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Formula(
      id: '3',
      name: 'Deep Mahogany Infusion',
      currentLevel: 4,
      targetLevel: 5,
      brand: 'Redken',
      processingTime: '35-40 min',
      isFavorite: false,
      tags: ['Color Treated', 'Fine Hair'],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Formula(
      id: '4',
      name: 'Copper Rose Balayage',
      currentLevel: 7,
      targetLevel: 8,
      brand: 'L\'Oréal',
      processingTime: '45-50 min',
      isFavorite: true,
      tags: ['Highlighted', 'Thick Hair'],
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
  ];

  void _loadFormulas() {
    if (isClosed) return;
    final formulas = List<Formula>.from(_mockFormulas);
    emit(
      state.copyWith(
        allFormulas: formulas,
        displayedFormulas: formulas,
        isLoading: false,
        clearError: true,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // User actions
  // ---------------------------------------------------------------------------

  void searchFormulas(String query) {
    final trimmed = query.trim();
    emit(
      state.copyWith(
        searchQuery: trimmed,
        displayedFormulas: _applyFilters(
          state.allFormulas,
          state.activeFilter,
          trimmed,
        ),
      ),
    );
  }

  void filterChanged(FormulaFilter filter) {
    emit(
      state.copyWith(
        activeFilter: filter,
        displayedFormulas: _applyFilters(
          state.allFormulas,
          filter,
          state.searchQuery,
        ),
      ),
    );
  }

  void toggleFavorite(String id) {
    final updated = state.allFormulas.map((f) {
      return f.id == id ? f.copyWith(isFavorite: !f.isFavorite) : f;
    }).toList();

    emit(
      state.copyWith(
        allFormulas: updated,
        displayedFormulas: _applyFilters(
          updated,
          state.activeFilter,
          state.searchQuery,
        ),
      ),
    );
  }

  /// Prepends a newly created formula to the top of the list
  void addFormula(Formula formula) {
    final updated = [formula, ...state.allFormulas];
    emit(
      state.copyWith(
        allFormulas: updated,
        displayedFormulas: _applyFilters(
          updated,
          state.activeFilter,
          state.searchQuery,
        ),
      ),
    );
  }

  void deleteFormula(String id) {
    final updated = state.allFormulas.where((f) => f.id != id).toList();

    emit(
      state.copyWith(
        allFormulas: updated,
        displayedFormulas: _applyFilters(
          updated,
          state.activeFilter,
          state.searchQuery,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  List<Formula> _applyFilters(
    List<Formula> formulas,
    FormulaFilter filter,
    String query,
  ) {
    var result = formulas;

    // Apply tab filter
    switch (filter) {
      case FormulaFilter.all:
        break;
      case FormulaFilter.recent:
        // Show formulas created within the last 7 days
        final cutoff = DateTime.now().subtract(const Duration(days: 7));
        result = result.where((f) => f.createdAt.isAfter(cutoff)).toList();
      case FormulaFilter.favorites:
        result = result.where((f) => f.isFavorite).toList();
    }

    // Apply search query
    if (query.isNotEmpty) {
      final lower = query.toLowerCase();
      result = result
          .where(
            (f) =>
                f.name.toLowerCase().contains(lower) ||
                f.brand.toLowerCase().contains(lower) ||
                f.tags.any((t) => t.toLowerCase().contains(lower)),
          )
          .toList();
    }

    return result;
  }
}
