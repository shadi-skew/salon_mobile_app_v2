import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

class ColorOptionsWidget extends StatelessWidget {
  const ColorOptionsWidget({
    super.key,
    required this.options,
    required this.onSelected,
    this.selectedOptionId,
  });

  final List<ColorOptionData> options;
  final void Function(String optionId) onSelected;
  final String? selectedOptionId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 52, right: 16, bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(22),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.4,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            final isSelected = selectedOptionId == option.id;
            return _ColorCard(
              option: option,
              isSelected: isSelected,
              isDisabled: selectedOptionId != null && !isSelected,
              onTap: selectedOptionId == null
                  ? () => onSelected(option.id)
                  : null,
            );
          },
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  const _ColorCard({
    required this.option,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  final ColorOptionData option;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0F6A6A)
                : Colors.transparent,
            width: isSelected ? 2.5 : 0,
          ),
          boxShadow: [
            if (!isDisabled)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDisabled ? 0.35 : 1.0,
          child: Row(
            children: [
              // Color circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: option.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: option.color.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Level + name
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level ${option.level}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.5,
                        color: ColorManager.blackTitle,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      option.name,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Check icon
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF0F6A6A),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
