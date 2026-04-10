import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';

/// Widget for selecting a hair color brand from available options
class BrandSelector extends StatelessWidget {
  const BrandSelector({
    super.key,
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  final HairBrand? selectedBrand;
  final ValueChanged<HairBrand> onBrandSelected;

  @override
  Widget build(BuildContext context) {
    const brands = HairBrand.values;
    return Container(
      height: 478,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.25,
        ),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = selectedBrand == brand;
          return _BrandTile(
            brand: brand,
            isSelected: isSelected,
            onTap: () => onBrandSelected(brand),
          );
        },
      ),
    );
  }
}

class _BrandTile extends StatelessWidget {
  const _BrandTile({
    required this.brand,
    required this.isSelected,
    required this.onTap,
  });

  final HairBrand brand;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.green : ColorManager.bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ColorManager.green : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(
                alpha: isSelected ? 0.15 : 0.05,
              ),
              blurRadius: isSelected ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey.shade50 : ColorManager.yellow,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  brand.initials,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? ColorManager.green
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              brand.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? ColorManager.white
                    : ColorManager.blackTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
