import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';

/// Shows the AI Settings bottom sheet.
Future<void> showAiSettingsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const _AiSettingsSheet(),
  );
}

class _AiSettingsSheet extends StatefulWidget {
  const _AiSettingsSheet();

  @override
  State<_AiSettingsSheet> createState() => _AiSettingsSheetState();
}

class _AiSettingsSheetState extends State<_AiSettingsSheet> {
  String? _faceShape;
  String? _hairLength;
  String? _stylePreference;
  String? _colorTone;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: ColorManager.separator,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'AI Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.blackText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Customize your preferences',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.grayText,
                  ),
                ),
                const SizedBox(height: 24),

                // Face Shape
                _SectionLabel('Face Shape'),
                const SizedBox(height: 8),
                _ChipGrid(
                  options: const ['oval', 'round', 'square', 'heart', 'oblong', 'diamond'],
                  columns: 3,
                  selected: _faceShape,
                  onSelected: (v) => setState(() => _faceShape = v),
                ),
                const SizedBox(height: 20),

                // Current Hair Length
                _SectionLabel('Current Hair Length'),
                const SizedBox(height: 8),
                _ChipGrid(
                  options: const ['short', 'medium', 'long'],
                  columns: 3,
                  selected: _hairLength,
                  onSelected: (v) => setState(() => _hairLength = v),
                ),
                const SizedBox(height: 20),

                // Style Preference
                _SectionLabel('Style Preference'),
                const SizedBox(height: 8),
                _ChipGrid(
                  options: const ['modern', 'classic', 'edgy', 'natural'],
                  columns: 2,
                  selected: _stylePreference,
                  onSelected: (v) => setState(() => _stylePreference = v),
                ),
                const SizedBox(height: 20),

                // Preferred Color Tone
                _SectionLabel('Preferred Color Tone'),
                const SizedBox(height: 8),
                _ChipGrid(
                  options: const ['warm', 'cool', 'neutral'],
                  columns: 3,
                  selected: _colorTone,
                  onSelected: (v) => setState(() => _colorTone = v),
                ),
                const SizedBox(height: 24),

                // Apply button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: ColorManager.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Apply Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: bottomPadding + 16),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorManager.blackText,
      ),
    );
  }
}

class _ChipGrid extends StatelessWidget {
  const _ChipGrid({
    required this.options,
    required this.columns,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final int columns;
  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selected == option;
        final chipWidth =
            (MediaQuery.of(context).size.width - 48 - (columns - 1) * 8) /
                columns;

        return GestureDetector(
          onTap: () => onSelected(option),
          child: Container(
            width: chipWidth,
            height: 41,
            decoration: BoxDecoration(
              color: isSelected ? ColorManager.green : const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(100),
              border: isSelected
                  ? null
                  : Border.all(color: ColorManager.separator),
            ),
            alignment: Alignment.center,
            child: Text(
              option,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : ColorManager.grayText,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
