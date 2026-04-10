import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/formula/formula_cubit.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/formula/formula_state.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/formula_card.dart';

/// Entry point for the Formulas tab. Provides the [FormulaCubit].
class MyFormulasPage extends StatelessWidget {
  const MyFormulasPage({super.key});

  static const String routeName = '/my_formulas';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormulaCubit(),
      child: const _MyFormulasView(),
    );
  }
}

class _MyFormulasView extends StatefulWidget {
  const _MyFormulasView();

  @override
  State<_MyFormulasView> createState() => _MyFormulasViewState();
}

class _MyFormulasViewState extends State<_MyFormulasView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 14),
            _buildSearchBar(context),
            const SizedBox(height: 14),
            _buildFilterTabs(context),
            const SizedBox(height: 14),
            Expanded(child: _buildFormulaList()),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'My Formulas',
              style: TextStyle(
                color: ColorManager.darkText,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Add new formula button
          GestureDetector(
            onTap: () async {
              final formula = await context.pushNamed<Formula>(
                AppRoutesNames.formulaCalculator,
                extra: {
                  'onFormulaCommitted': (Formula f) {
                    if (context.mounted) {
                      context.read<FormulaCubit>().addFormula(f);
                    }
                  },
                },
              );
              if (formula != null && context.mounted) {
                context.read<FormulaCubit>().addFormula(formula);
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: ColorManager.green, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search bar
  // ---------------------------------------------------------------------------

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (query) =>
              context.read<FormulaCubit>().searchFormulas(query),
          style: const TextStyle(fontSize: 14, color: ColorManager.blackTitle),
          decoration: InputDecoration(
            hintText: 'Search formulas...',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey.shade400,
              size: 20,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Filter tabs: All / Recent / Favorites
  // ---------------------------------------------------------------------------

  Widget _buildFilterTabs(BuildContext context) {
    return BlocBuilder<FormulaCubit, FormulaState>(
      buildWhen: (prev, curr) => prev.activeFilter != curr.activeFilter,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: FormulaFilter.values
                .map(
                  (filter) => Expanded(
                    child: _FilterTab(
                      label: _filterLabel(filter),
                      isActive: state.activeFilter == filter,
                      onTap: () =>
                          context.read<FormulaCubit>().filterChanged(filter),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  String _filterLabel(FormulaFilter filter) {
    switch (filter) {
      case FormulaFilter.all:
        return 'All';
      case FormulaFilter.recent:
        return 'Recent';
      case FormulaFilter.favorites:
        return 'Favorites';
    }
  }

  // ---------------------------------------------------------------------------
  // Formula list
  // ---------------------------------------------------------------------------

  Widget _buildFormulaList() {
    return BlocBuilder<FormulaCubit, FormulaState>(
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          itemCount: state.displayedFormulas.length,
          separatorBuilder: (_, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final formula = state.displayedFormulas[index];
            return FormulaCard(
              formula: formula,
              onFavoriteTap: () =>
                  context.read<FormulaCubit>().toggleFavorite(formula.id),
              onTap: () {
                // TODO: Navigate to FormulaDetailPage
              },
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Filter tab pill button
// ---------------------------------------------------------------------------

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? ColorManager.green : ColorManager.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActive ? ColorManager.green : Colors.grey.shade200,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: ColorManager.green.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: isActive ? ColorManager.white : Colors.grey.shade600,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}
