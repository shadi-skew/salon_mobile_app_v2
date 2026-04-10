import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/calculator/calculator_cubit.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/brand_selector.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/hair_level_selector.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/widgets/step_indicator.dart';

import '../../../../../../core/resources/app_routes_names.dart';

/// Multi-step formula calculator page
class FormulaCalculatorPage extends StatelessWidget {
  const FormulaCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorCubit(),
      child: const _FormulaCalculatorView(),
    );
  }
}

class _FormulaCalculatorView extends StatefulWidget {
  const _FormulaCalculatorView();

  @override
  State<_FormulaCalculatorView> createState() => _FormulaCalculatorViewState();
}

class _FormulaCalculatorViewState extends State<_FormulaCalculatorView> {
  late PageController _pageController;
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  EdgeInsets _stepScrollPadding(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return EdgeInsets.fromLTRB(20, 0, 20, bottomInset + 12);
  }

  Future<void> _calculateFormula(BuildContext context) async {
    final cubitState = context.read<CalculatorCubit>().state;
    if (!cubitState.isComplete) return;

    final parentExtra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final onFormulaCommitted =
        parentExtra?['onFormulaCommitted'] as void Function(Formula)?;

    final formula = await context.pushNamed<Formula>(
      AppRoutesNames.formulaResults,
      extra: {
        'currentLevel': cubitState.currentLevel!,
        'targetLevel': cubitState.targetLevel!,
        'brand': cubitState.selectedBrand!,
        if (onFormulaCommitted != null)
          'onFormulaCommitted': onFormulaCommitted,
      },
    );

    // Propagate saved formula back to MyFormulasPage (legacy path when results
    // pops with a formula and no in-place callback was used).
    if (formula != null && context.mounted) {
      Navigator.pop(context, formula);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header with close button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Formula Calculator',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.darkText,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Step $_currentStep of 3',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffA5A5A5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: ColorManager.blackTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Step indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StepIndicator(currentStep: _currentStep, totalSteps: 3),
            ),
            const SizedBox(height: 28),
            // Page view for steps
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentStep = index + 1);
                },
                children: [
                  _buildStep1BrandSelection(context),
                  _buildStep2CurrentLevel(context),
                  _buildStep3TargetLevel(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 1: Brand Selection
  // ---------------------------------------------------------------------------

  Widget _buildStep1BrandSelection(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      buildWhen: (prev, curr) => prev.selectedBrand != curr.selectedBrand,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: _stepScrollPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select your color brand',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blackTitle,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the brand you\'ll be using',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              BrandSelector(
                selectedBrand: state.selectedBrand,
                onBrandSelected: (brand) {
                  context.read<CalculatorCubit>().selectBrand(brand);
                },
              ),
              const SizedBox(height: 32),
              _buildNavButtons(
                context: context,
                showBack: false,
                buttonLabel: 'Continue',
                onNext: state.canProceedFromBrand ? _nextStep : null,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2: Current Hair Level
  // ---------------------------------------------------------------------------

  Widget _buildStep2CurrentLevel(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      buildWhen: (prev, curr) => prev.currentLevel != curr.currentLevel,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: _stepScrollPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What\'s your current hair level?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blackTitle,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the color that best matches your current hair',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              HairLevelSelector(
                selectedLevel: state.currentLevel,
                onLevelSelected: (level) {
                  context.read<CalculatorCubit>().selectCurrentLevel(level);
                },
              ),
              const SizedBox(height: 32),
              _buildNavButtons(
                context: context,
                showBack: true,
                buttonLabel: 'Continue',
                onBack: _previousStep,
                onNext: state.canProceedFromCurrentLevel ? _nextStep : null,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3: Target Hair Level
  // ---------------------------------------------------------------------------

  Widget _buildStep3TargetLevel(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
      buildWhen: (prev, curr) => prev.targetLevel != curr.targetLevel,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: _stepScrollPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What\'s your target level?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blackTitle,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the desired hair color level',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              HairLevelSelector(
                selectedLevel: state.targetLevel,
                onLevelSelected: (level) {
                  context.read<CalculatorCubit>().selectTargetLevel(level);
                },
              ),
              const SizedBox(height: 32),
              _buildNavButtons(
                context: context,
                showBack: true,
                buttonLabel: 'Calculate Formula',
                onBack: _previousStep,
                onNext: state.canProceedFromTargetLevel
                    ? () => _calculateFormula(context)
                    : null,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Navigation buttons
  // ---------------------------------------------------------------------------

  Widget _buildNavButtons({
    required BuildContext context,
    required bool showBack,
    required String buttonLabel,
    VoidCallback? onBack,
    VoidCallback? onNext,
  }) {
    return Row(
      children: [
        if (showBack) ...[
          GestureDetector(
            onTap: onBack,
            child: Container(
              height: 60,
              width: 113,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD4D0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: GestureDetector(
            onTap: onNext,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: onNext != null
                    ? ColorManager.green
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  buttonLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: onNext != null
                        ? ColorManager.white
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
