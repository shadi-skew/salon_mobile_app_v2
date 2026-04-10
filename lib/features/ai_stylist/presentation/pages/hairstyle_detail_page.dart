import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/widgets/photo_source_bottom_sheet.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/pages/camera_page.dart';

class _RecommendedStyle {
  final String tag;
  final String name;
  final String description;
  final Color tagColor;
  final String imagePath;

  const _RecommendedStyle({
    required this.tag,
    required this.name,
    required this.description,
    required this.tagColor,
    required this.imagePath,
  });
}

const _recommendedStyles = [
  _RecommendedStyle(
    tag: 'Casual',
    name: 'Beach Waves',
    description: 'Effortless, natural waves',
    tagColor: ColorManager.yellow,
    imagePath: 'assets/images/hairstyle_pink.png',
  ),
  _RecommendedStyle(
    tag: 'Modern',
    name: 'Long Layered',
    description: 'Soft layers with movement',
    tagColor: Color(0xFFD5E6F6),
    imagePath: 'assets/images/hairstyle_orange.png',
  ),
  _RecommendedStyle(
    tag: 'Short',
    name: 'Pixie Cut',
    description: 'Low maintenance, chic',
    tagColor: Color(0xFFFFDCED),
    imagePath: 'assets/images/hairstyle_green.png',
  ),
  _RecommendedStyle(
    tag: 'Bold',
    name: 'Curly Voluminous',
    description: 'Full-bodied curls',
    tagColor: Color(0xFFD5F0E3),
    imagePath: 'assets/images/hairstyle_purple.png',
  ),
];

class HairstyleDetailPage extends StatefulWidget {
  const HairstyleDetailPage({
    super.key,
    required this.title,
    this.cardCount,
  });

  final String title;
  final int? cardCount;

  @override
  State<HairstyleDetailPage> createState() => _HairstyleDetailPageState();
}

class _HairstyleDetailPageState extends State<HairstyleDetailPage> {
  String? _selectedImagePath;
  int? _selectedStyleIndex;

  Future<void> _onUploadTapped() async {
    final source = await showPhotoSourceBottomSheet(context);
    if (source == null || !mounted) return;

    String? path;

    if (source == PhotoSource.camera) {
      path = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (_) => const CameraPage()),
      );
    } else {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      path = image?.path;
    }

    if (path != null && mounted) {
      setState(() {
        _selectedImagePath = path;
        _selectedStyleIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = _selectedImagePath != null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
              child: hasPhoto ? _buildPhotoWithStyles() : _buildUploadState(),
            ),
            // Generate button (visible only when a style is selected)
            if (_selectedStyleIndex != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: GestureDetector(
                  onTap: () => context.pushNamed(
                    AppRoutesNames.styleResult,
                    extra: {
                      'title': widget.title,
                      'imagePath': _selectedImagePath,
                      'cardCount': widget.cardCount,
                    },
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: ColorManager.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Generate Style',
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
          ],
        ),
      ),
    );
  }

  // ── Upload state (no photo yet) ─────────────────────────

  Widget _buildUploadState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorManager.blackText,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GestureDetector(
              onTap: _onUploadTapped,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorManager.separator,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 28,
                      color: ColorManager.grayText,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload Photo',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorManager.grayText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── Photo uploaded + recommended styles ─────────────────

  Widget _buildPhotoWithStyles() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Uploaded photo
          GestureDetector(
            onTap: _onUploadTapped,
            child: Container(
              height: 339,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(_selectedImagePath!),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Change Photo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
          const SizedBox(height: 32),
          // Recommended Styles heading
          const Text(
            'Recommended Styles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorManager.blackText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a style to preview how it would look with the new color',
            style: TextStyle(
              fontSize: 14,
              color: ColorManager.grayText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          // Style cards grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),
            itemCount: _recommendedStyles.length,
            itemBuilder: (context, index) {
              final style = _recommendedStyles[index];
              final isSelected = _selectedStyleIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedStyleIndex = index),
                child: _StyleCard(style: style, isSelected: isSelected),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Style recommendation card ───────────────────────────

class _StyleCard extends StatelessWidget {
  const _StyleCard({
    required this.style,
    required this.isSelected,
  });

  final _RecommendedStyle style;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? ColorManager.green : ColorManager.separator,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  style.imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: style.tagColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              style.tag,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ColorManager.grayText,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Name
          Text(
            style.name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: ColorManager.blackText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            style.description,
            style: TextStyle(
              fontSize: 12,
              color: ColorManager.grayText,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
