import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';

/// White card showing a bullet list of processing instructions.
class ProcessingNotesCard extends StatelessWidget {
  const ProcessingNotesCard({super.key, required this.notes});

  final List<String> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
          const Text(
            'Notes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ColorManager.blackTitle,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          ...notes.map(_buildBullet),
        ],
      ),
    );
  }

  Widget _buildBullet(String note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: const BoxDecoration(
              color: ColorManager.green,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 14,
                color: ColorManager.blackTitle,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
