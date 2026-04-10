import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';

class _ProcessStep {
  final int number;
  final String title;
  final String duration;
  final String product;

  const _ProcessStep({
    required this.number,
    required this.title,
    required this.duration,
    required this.product,
  });
}

class _ColorSwatch {
  final String label;
  final Color color;

  const _ColorSwatch({required this.label, required this.color});
}

const _processSteps = [
  _ProcessStep(
    number: 1,
    title: 'Pre-Lighten',
    duration: '30-40 min',
    product: '20 vol developer',
  ),
  _ProcessStep(
    number: 2,
    title: 'Tone',
    duration: '15-20 min',
    product: 'Beige toner 7.31',
  ),
  _ProcessStep(
    number: 3,
    title: 'Treatment',
    duration: '5 min',
    product: 'Bond Builder',
  ),
];

const _colorSwatches = [
  _ColorSwatch(label: 'Current', color: Color(0xFF3B2314)),
  _ColorSwatch(label: 'Mid', color: Color(0xFFB8763C)),
  _ColorSwatch(label: 'Target', color: Color(0xFFD4A96A)),
  _ColorSwatch(label: 'Toned', color: Color(0xFFE8C99B)),
];

class StyleResultPage extends StatefulWidget {
  const StyleResultPage({
    super.key,
    required this.title,
    required this.imagePath,
    this.cardCount,
  });

  final String title;
  final String imagePath;
  final int? cardCount;

  @override
  State<StyleResultPage> createState() => _StyleResultPageState();
}

class _StyleResultPageState extends State<StyleResultPage> {
  bool _showComparison = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: ColorManager.blackText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.blackText,
                        letterSpacing: -0.28,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.cardCount != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.background,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        '${widget.cardCount} styles',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.grayText,
                          height: 21 / 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Comparison toggle
                    _buildComparisonToggle(),
                    const SizedBox(height: 16),
                    // Image(s)
                    _showComparison
                        ? _buildComparisonView()
                        : _buildSingleImage(),
                    const SizedBox(height: 32),
                    // Process Steps
                    _buildProcessSteps(),
                    const SizedBox(height: 32),
                    // Color Preview
                    _buildColorPreview(),
                    const SizedBox(height: 24),
                    // Action buttons row
                    _buildActionButtonsRow(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Bottom button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: GestureDetector(
                onTap: () {
                  // TODO: Book appointment
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: ColorManager.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Comparison toggle ─────────────────────────────────

  Widget _buildComparisonToggle() {
    return Center(
      child: GestureDetector(
        onTap: () => setState(() => _showComparison = !_showComparison),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.background,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _showComparison
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 24,
                color: ColorManager.blackText,
              ),
              const SizedBox(width: 8),
              Text(
                _showComparison ? 'Hide Comparison' : 'Show Comparison',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.blackText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Single result image ───────────────────────────────

  Widget _buildSingleImage() {
    return Container(
      height: 339,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(widget.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ── Side-by-side comparison ───────────────────────────

  Widget _buildComparisonView() {
    return Container(
      height: 339,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // Before (original)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                  // Slight tint to differentiate
                  Container(
                    color: Colors.blue.withValues(alpha: 0.05),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Before',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 2, color: Colors.white),
            // After (result)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'After',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Process Steps ─────────────────────────────────────

  Widget _buildProcessSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Process Steps',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorManager.blackText,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_processSteps.length, (index) {
          final step = _processSteps[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < _processSteps.length - 1 ? 16 : 0,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorManager.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Step number
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${step.number}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.blackText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Step details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.blackText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              step.duration,
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorManager.grayText,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Text(
                                step.product,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: ColorManager.grayText,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // ── Color Preview ─────────────────────────────────────

  Widget _buildColorPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color Preview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorManager.blackText,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ColorManager.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _colorSwatches.map((swatch) {
              return Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: swatch.color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    swatch.label,
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorManager.grayText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ── Save / Share action buttons ───────────────────────

  Widget _buildActionButtonsRow() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: Save result
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: ColorManager.background,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_outline, size: 20,
                      color: ColorManager.blackText),
                  SizedBox(width: 8),
                  Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: Share result
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: ColorManager.background,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share_outlined, size: 20,
                      color: ColorManager.blackText),
                  SizedBox(width: 8),
                  Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.blackText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
