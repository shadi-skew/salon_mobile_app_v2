import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/timer_session.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/pages/timer/timer_detail_page.dart';

/// Page displaying calculated formula details with save and timer options
class FormulaResultsPage extends StatefulWidget {
  const FormulaResultsPage({
    super.key,
    required this.currentLevel,
    required this.targetLevel,
    required this.brand,
    this.onFormulaCommitted,
  });

  static const String routeName = '/formula_results';

  final int currentLevel;
  final int targetLevel;
  final HairBrand brand;

  /// When set (e.g. opened from My Formulas flow), saving keeps this route
  /// visible and hides the Save button; the formula is added via this callback.
  final void Function(Formula formula)? onFormulaCommitted;

  @override
  State<FormulaResultsPage> createState() => _FormulaResultsPageState();
}

class _FormulaResultsPageState extends State<FormulaResultsPage> {
  bool _hasSavedFormula = false;
  String? _savedFormulaName;

  /// Processing time in minutes based on level difference (min 20 min)
  int get _processingTimeMinutes {
    final diff = (widget.targetLevel - widget.currentLevel).abs();
    return 20 + (diff * 5);
  }

  String get _processingTimeLabel => '$_processingTimeMinutes min';

  void _startTimer() {
    final session = TimerSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chairNumber: 1,
      clientName: 'Client',
      serviceType: '${widget.brand.label} Color Treatment',
      totalSeconds: _processingTimeMinutes * 60,
      targetLevel: widget.targetLevel,
      notes: const [
        'Check every 10 minutes',
        'Apply toner when target level is reached',
        'Rinse thoroughly before toner application',
      ],
    );
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => TimerDetailPage(session: session)),
    );
  }

  Formula _formulaWithName(String name) {
    return Formula(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      brand: widget.brand.label,
      currentLevel: widget.currentLevel,
      targetLevel: widget.targetLevel,
      processingTime: _processingTimeLabel,
      createdAt: DateTime.now(),
    );
  }

  void _openSaveFormulaSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _SaveFormulaNameSheet(
          formulaBuilder: _formulaWithName,
          onSaveSuccess: (formula) {
            if (widget.onFormulaCommitted != null) {
              widget.onFormulaCommitted!(formula);
              if (mounted) {
                setState(() {
                  _hasSavedFormula = true;
                  _savedFormulaName = formula.name;
                });
              }
            } else {
              if (mounted) context.pop(formula);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return Scaffold(
      backgroundColor: ColorManager.lightGrey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Formula Calculator',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.blackTitle,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!context.mounted) return;
                      // Clears the stack; `home=1` tells [RootPage] to select the Home tab.
                      context.go('${AppRoutesNames.root}?home=1');
                    },
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
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Formula',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: ColorManager.blackTitle,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'Follow these instructions carefully',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_savedFormulaName != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Formula Name (Optional)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      child: Text(
                        _savedFormulaName!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.blackTitle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 24 + bottomInset + 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Hair level display
                          Row(
                            children: [
                              Expanded(
                                child: _buildHairLevelBox(
                                  level: widget.currentLevel,
                                  label: 'Current',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.grey.shade400,
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: _buildHairLevelBox(
                                  level: widget.targetLevel,
                                  label: 'Target',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Formula details card
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildFormulaDetailRow(
                                  label: 'Brand',
                                  value: widget.brand.label,
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  height: 1,
                                ),
                                const SizedBox(height: 12),
                                _buildFormulaDetailRow(
                                  label: 'Color Amount',
                                  value: '60g',
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  height: 1,
                                ),
                                const SizedBox(height: 12),
                                _buildFormulaDetailRow(
                                  label: 'Developer',
                                  value: '20 Vol / 60g (1:1)',
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  height: 1,
                                ),
                                const SizedBox(height: 12),
                                _buildFormulaDetailRow(
                                  label: 'Lift Capability',
                                  value: '0 levels',
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  height: 1,
                                ),
                                const SizedBox(height: 12),
                                _buildFormulaDetailRow(
                                  label: 'Processing Time',
                                  value: _processingTimeLabel,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Instructions box
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9E6),
                              border: Border.all(
                                color: ColorManager.darkOrange,
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: const Text(
                              'Apply to roots first, then work through mid-lengths and ends. Process for the recommended time.',
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorManager.darkOrange,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        if (!_hasSavedFormula) ...[
                          GestureDetector(
                            onTap: _openSaveFormulaSheet,
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: ColorManager.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.save_outlined,
                                    color: ColorManager.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Save Formula',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        GestureDetector(
                          onTap: _startTimer,
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: ColorManager.lightOrange,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  color: ColorManager.darkText,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Start Timer ($_processingTimeMinutes min)',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.darkText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHairLevelBox({required int level, required String label}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: hairLevelColor(level),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level $level',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.blackTitle,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaDetailRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: ColorManager.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Bottom sheet content with its own [TextEditingController] lifecycle so the
/// controller is not disposed while the sheet (or keyboard inset) can rebuild.
class _SaveFormulaNameSheet extends StatefulWidget {
  const _SaveFormulaNameSheet({
    required this.formulaBuilder,
    required this.onSaveSuccess,
  });

  final Formula Function(String name) formulaBuilder;
  final void Function(Formula formula) onSaveSuccess;

  @override
  State<_SaveFormulaNameSheet> createState() => _SaveFormulaNameSheetState();
}

class _SaveFormulaNameSheetState extends State<_SaveFormulaNameSheet> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a formula name.')),
      );
      return;
    }
    final formula = widget.formulaBuilder(name);
    Navigator.of(context).pop();
    widget.onSaveSuccess(formula);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Name Your Formula',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.blackTitle,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(height: 1, color: ColorManager.lightGreyDivider),
                const SizedBox(height: 20),
                Text(
                  'Formula name',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      hintText: 'Enter formula name',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _submit,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: ColorManager.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save_outlined,
                          color: ColorManager.white,
                          size: 22,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Save Formula',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
