import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 28),

              // Avatar + name
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0F6A6A).withValues(alpha: 0.06),
                      const Color(0xFF0F6A6A).withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF0F6A6A).withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F6A6A).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF0F6A6A).withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 40,
                        color: Color(0xFF0F6A6A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Guest User',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.blackTitle,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sign in to save your preferences',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F6A6A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Menu sections
              _MenuSection(
                title: 'Activity',
                items: [
                  _MenuItem(
                    icon: Icons.history_rounded,
                    title: 'Consultation History',
                  ),
                  _MenuItem(
                    icon: Icons.favorite_rounded,
                    title: 'Saved Styles',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _MenuSection(
                title: 'Preferences',
                items: [
                  _MenuItem(
                    icon: Icons.notifications_rounded,
                    title: 'Notifications',
                  ),
                  _MenuItem(
                    icon: Icons.language_rounded,
                    title: 'Language',
                  ),
                  _MenuItem(
                    icon: Icons.dark_mode_rounded,
                    title: 'Appearance',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _MenuSection(
                title: 'Support',
                items: [
                  _MenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & FAQ',
                  ),
                  _MenuItem(
                    icon: Icons.info_outline_rounded,
                    title: 'About',
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  const _MenuItem({required this.icon, required this.title});
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.title, required this.items});

  final String title;
  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;
              return Column(
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.vertical(
                      top: index == 0
                          ? const Radius.circular(16)
                          : Radius.zero,
                      bottom: isLast
                          ? const Radius.circular(16)
                          : Radius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F6A6A)
                                  .withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              item.icon,
                              color: const Color(0xFF0F6A6A),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.blackTitle,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Divider(
                        height: 0.5,
                        thickness: 0.5,
                        color: Colors.grey.shade200,
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
}
