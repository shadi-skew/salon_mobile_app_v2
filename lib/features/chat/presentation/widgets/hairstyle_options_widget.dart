import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

class HairstyleOptionsWidget extends StatelessWidget {
  const HairstyleOptionsWidget({
    super.key,
    required this.options,
    required this.onSelected,
    this.selectedOptionId,
  });

  final List<HairstyleOptionData> options;
  final void Function(String optionId) onSelected;
  final String? selectedOptionId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 52, right: 16, bottom: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.62,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = selectedOptionId == option.id;
          return _HairstyleCard(
            option: option,
            isSelected: isSelected,
            isDisabled: selectedOptionId != null && !isSelected,
            onTap: selectedOptionId == null
                ? () => onSelected(option.id)
                : null,
          );
        },
      ),
    );
  }
}

class _HairstyleCard extends StatelessWidget {
  const _HairstyleCard({
    required this.option,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  final HairstyleOptionData option;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE87156)
                : const Color(0xFFEEEEEE),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: [
            if (!isDisabled)
              BoxShadow(
                color: isSelected
                    ? const Color(0xFFE87156).withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: isSelected ? 12 : 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDisabled ? 0.45 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image area with colored background
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: option.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: option.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            option.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => _placeholder(),
                          ),
                        )
                      : _placeholder(),
                ),
              ),
              // Tag + Title + Description
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tag chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F6A6A),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        option.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    // Title
                    Text(
                      option.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.5,
                        color: ColorManager.blackTitle,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    // Description
                    Text(
                      option.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Center(
      child: Icon(
        Icons.person,
        size: 44,
        color: Colors.white.withValues(alpha: 0.7),
      ),
    );
  }
}
