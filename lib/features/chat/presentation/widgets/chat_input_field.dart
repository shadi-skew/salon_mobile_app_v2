import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    super.key,
    required this.onSendText,
    required this.onSendImage,
    this.enabled = true,
  });

  final void Function(String text) onSendText;
  final void Function(String imagePath) onSendImage;
  final bool enabled;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _imagePicker = ImagePicker();

  bool get _hasText => _controller.text.trim().isNotEmpty;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSendText(text);
    _controller.clear();
    setState(() {});
  }

  Future<void> _pickImage() async {
    _focusNode.unfocus();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Share a photo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Take a new photo or choose from your gallery',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _PickerOption(
                        icon: Icons.camera_alt_rounded,
                        label: 'Camera',
                        onTap: () => Navigator.pop(ctx, ImageSource.camera),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PickerOption(
                        icon: Icons.photo_library_rounded,
                        label: 'Gallery',
                        onTap: () => Navigator.pop(ctx, ImageSource.gallery),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (source == null) return;

    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (picked != null) {
        widget.onSendImage(picked.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not access camera/gallery')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Camera button
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              color: widget.enabled
                  ? const Color(0xFF0F6A6A).withValues(alpha: 0.08)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(22),
            ),
            child: IconButton(
              onPressed: widget.enabled ? _pickImage : null,
              icon: const Icon(Icons.camera_alt_rounded, size: 22),
              color: const Color(0xFF0F6A6A),
              disabledColor: Colors.grey.shade400,
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(width: 10),
          // Text field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                minLines: 1,
                style: const TextStyle(fontSize: 15, height: 1.4),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Send button
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              color: (widget.enabled && _hasText)
                  ? const Color(0xFF0F6A6A)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(22),
            ),
            child: IconButton(
              onPressed: (widget.enabled && _hasText) ? _send : null,
              icon: const Icon(Icons.arrow_upward_rounded, size: 22),
              color: Colors.white,
              disabledColor: Colors.grey.shade400,
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  const _PickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0F6A6A).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF0F6A6A).withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF0F6A6A), size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F6A6A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
