import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

class HairColorOptionsWidget extends StatelessWidget {
  const HairColorOptionsWidget({
    super.key,
    required this.colors,
    required this.onSelected,
    this.selectedColorName,
  });

  final List<HairColor> colors;
  final void Function(HairColor color) onSelected;
  final String? selectedColorName;

  bool get _isLocked => selectedColorName != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 52, right: 16, bottom: 10, top: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D8B8B).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.palette_rounded,
                      size: 16, color: Color(0xFF0D8B8B)),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Pick a shade',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: -0.2,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${colors.length} colors',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Color gradient strip preview
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 6,
                child: Row(
                  children: colors.map((c) {
                    return Expanded(
                      child: Container(color: Color(int.parse(c.hex))),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Color list
            ...List.generate(colors.length, (i) {
              final color = colors[i];
              final isSelected = selectedColorName == color.name;
              final chipColor = Color(int.parse(color.hex));
              final isLast = i == colors.length - 1;

              return GestureDetector(
                onTap: _isLocked ? null : () => onSelected(color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(bottom: isLast ? 0 : 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? chipColor.withValues(alpha: 0.08)
                        : const Color(0xFFF8F8FA),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? chipColor.withValues(alpha: 0.5)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Color swatch
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: chipColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: chipColor.withValues(alpha: 0.35),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(Icons.check_rounded,
                                size: 18, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      // Name + level
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              color.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: const Color(0xFF1A1A1A),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              'Level ${color.level}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Trailing indicator
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: chipColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Selected',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: chipColor,
                            ),
                          ),
                        )
                      else if (!_isLocked)
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: Colors.grey.shade300,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
