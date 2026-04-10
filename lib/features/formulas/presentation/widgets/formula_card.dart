import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';

/// Card widget displaying a saved hair color formula.
///
/// Shows the formula name, current → target hair levels, brand/processing time
/// info, tags, and a favourite toggle.
class FormulaCard extends StatelessWidget {
  const FormulaCard({
    super.key,
    required this.formula,
    required this.onFavoriteTap,
    this.onTap,
  });

  final Formula formula;
  final VoidCallback onFavoriteTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------------
            // Header: name + favourite icon
            // ----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      formula.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.blackTitle,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onFavoriteTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        formula.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: formula.isFavorite
                            ? ColorManager.secondary
                            : Colors.grey.shade300,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ----------------------------------------------------------------
            // Hair level row: current → target
            // ----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _HairLevelBadge(
                      level: formula.currentLevel,
                      label: 'Current',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey.shade400,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: _HairLevelBadge(
                      level: formula.targetLevel,
                      label: 'Target',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ----------------------------------------------------------------
            // Info box: brand + processing time on teal background
            // ----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(label: 'Brand', value: formula.brand),
                    const SizedBox(height: 6),
                    _InfoRow(
                      label: 'Processing Time',
                      value: formula.processingTime,
                    ),
                  ],
                ),
              ),
            ),

            // ----------------------------------------------------------------
            // Tags row (only shown when there are tags)
            // ----------------------------------------------------------------
            if (formula.tags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: formula.tags.map(_buildTag).toList(),
                ),
              ),
            ] else
              const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Private sub-widgets
// ----------------------------------------------------------------------------

/// Circular hair-level swatch with level number and label below
class _HairLevelBadge extends StatelessWidget {
  const _HairLevelBadge({required this.level, required this.label});

  final int level;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: hairLevelColor(level),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: 0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Level $level',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.blackTitle,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: ColorManager.blackGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A single label/value row inside the teal info box
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: ColorManager.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
