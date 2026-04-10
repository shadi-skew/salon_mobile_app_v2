import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/widgets/ai_settings_bottom_sheet.dart';

enum _StyleCategory { cuts, colors, styles }

class _HairstyleItem {
  final String title;
  final String description;
  final String difficulty;
  final String duration;
  final Color backgroundColor;
  final String imagePath;
  final _StyleCategory category;

  const _HairstyleItem({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.duration,
    required this.backgroundColor,
    required this.imagePath,
    required this.category,
  });
}

const _hairstyles = [
  // Cuts
  _HairstyleItem(
    title: 'Long Layered Cut',
    description: 'Face-framing layers with long length',
    difficulty: 'Medium',
    duration: '45 min',
    backgroundColor: ColorManager.pink,
    imagePath: 'assets/images/hairstyle_pink.png',
    category: _StyleCategory.cuts,
  ),
  _HairstyleItem(
    title: 'Blunt Bob',
    description: 'Sharp, clean cut at chin length',
    difficulty: 'Easy',
    duration: '30 min',
    backgroundColor: ColorManager.darkOrange,
    imagePath: 'assets/images/hairstyle_orange.png',
    category: _StyleCategory.cuts,
  ),
  _HairstyleItem(
    title: 'Textured Pixie',
    description: 'Short and edgy with textured layers',
    difficulty: 'Hard',
    duration: '40 min',
    backgroundColor: ColorManager.green,
    imagePath: 'assets/images/hairstyle_green.png',
    category: _StyleCategory.cuts,
  ),
  // Colors
  _HairstyleItem(
    title: 'Curtain Bangs',
    description: 'Soft face-framing bangs parted in center',
    difficulty: 'Medium',
    duration: '25 min',
    backgroundColor: Color(0xFFD5C8F0),
    imagePath: 'assets/images/hairstyle_purple.png',
    category: _StyleCategory.colors,
  ),
  _HairstyleItem(
    title: 'Balayage Blend',
    description: 'Hand-painted highlights for a natural look',
    difficulty: 'Hard',
    duration: '90 min',
    backgroundColor: ColorManager.darkOrange,
    imagePath: 'assets/images/hairstyle_orange.png',
    category: _StyleCategory.colors,
  ),
  // Styles
  _HairstyleItem(
    title: 'Shaggy Lob',
    description: 'Shoulder-length with choppy layers',
    difficulty: 'Medium',
    duration: '35 min',
    backgroundColor: ColorManager.pink,
    imagePath: 'assets/images/hairstyle_pink.png',
    category: _StyleCategory.styles,
  ),
  _HairstyleItem(
    title: 'Asymmetric Cut',
    description: 'Modern uneven length for bold style',
    difficulty: 'Hard',
    duration: '50 min',
    backgroundColor: ColorManager.darkOrange,
    imagePath: 'assets/images/hairstyle_orange.png',
    category: _StyleCategory.styles,
  ),
  _HairstyleItem(
    title: 'Beach Waves',
    description: 'Effortless, natural waves for any occasion',
    difficulty: 'Easy',
    duration: '20 min',
    backgroundColor: ColorManager.green,
    imagePath: 'assets/images/hairstyle_green.png',
    category: _StyleCategory.styles,
  ),
];

class AiStylistPage extends StatefulWidget {
  const AiStylistPage({super.key});

  @override
  State<AiStylistPage> createState() => _AiStylistPageState();
}

class _AiStylistPageState extends State<AiStylistPage> {
  int _selectedTabIndex = 0;
  final _tabs = const ['All Styles', 'Cuts', 'Colors', 'Styles'];

  static const _tabCategories = <int, _StyleCategory?>{
    0: null, // All Styles
    1: _StyleCategory.cuts,
    2: _StyleCategory.colors,
    3: _StyleCategory.styles,
  };

  List<_HairstyleItem> get _filteredHairstyles {
    final category = _tabCategories[_selectedTabIndex];
    if (category == null) return _hairstyles;
    return _hairstyles.where((h) => h.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 16),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Try AI styles',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorManager.grayText,
                            letterSpacing: -0.16,
                          ),
                        ),
                        const Text(
                          'AI Stylist',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.blackText,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showAiSettingsBottomSheet(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: ColorManager.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Filter tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final isSelected = _selectedTabIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTabIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(
                          right: index < _tabs.length - 1 ? 8 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorManager.green
                              : ColorManager.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isSelected
                                ? ColorManager.green
                                : Colors.grey.shade200,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: ColorManager.green
                                        .withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _tabs[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            // Hairstyle grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.66,
                ),
                itemCount: _filteredHairstyles.length,
                itemBuilder: (context, index) {
                  final item = _filteredHairstyles[index];
                  return GestureDetector(
                    onTap: () => context.pushNamed(
                      AppRoutesNames.hairstyleDetail,
                      extra: {
                        'title': item.title,
                        'cardCount': _filteredHairstyles.length,
                      },
                    ),
                    child: _HairstyleCard(item: item),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}

class _HairstyleCard extends StatelessWidget {
  const _HairstyleCard({required this.item});

  final _HairstyleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 128,
            width: double.infinity,
            decoration: BoxDecoration(
              color: item.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                alignment: Alignment.topCenter,
                item.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorManager.blackText,
              height: 18 / 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            item.description,
            style: TextStyle(
              fontSize: 12,
              color: ColorManager.grayText,
              height: 16 / 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          // Tags
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.yellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.difficulty,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.grayText,
                    height: 15 / 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.duration,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.grayText,
                    height: 15 / 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
