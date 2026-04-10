import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/api/api_consumer.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/features/chat/data/data_sources/chat_api_service.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/manager/chat_cubit.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/pages/chat_page.dart';
import 'package:salon_mobile_app_v2/features/home/presentation/pages/home_page.dart';
import 'package:salon_mobile_app_v2/features/profile/presentation/pages/profile_page.dart';
import 'package:salon_mobile_app_v2/injection.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  late final ChatCubit _chatCubit;
  String? _lastHandledHomeResetUri;

  @override
  void initState() {
    super.initState();
    _chatCubit = ChatCubit(
      apiService: RemoteChatApiService(getIt<ApiConsumer>()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uri = GoRouterState.of(context).uri;
    if (uri.queryParameters['home'] != '1') {
      _lastHandledHomeResetUri = null;
      return;
    }
    final full = uri.toString();
    if (_lastHandledHomeResetUri == full) return;
    _lastHandledHomeResetUri = full;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _currentIndex = 0);
      final router = GoRouter.of(context);
      if (router.state.uri.queryParameters['home'] == '1') {
        router.go(AppRoutesNames.root);
      }
    });
  }

  @override
  void dispose() {
    _chatCubit.close();
    super.dispose();
  }

  void _goToChat() {
    setState(() => _currentIndex = 1);
  }

  void _goToFormulas() {
    context.push(AppRoutesNames.myFormulasPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(
            onNavigateToChat: _goToChat,
            onNavigateToFormulas: _goToFormulas,
          ),
          BlocProvider.value(value: _chatCubit, child: const ChatPage()),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  isActive: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                _NavItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  activeIcon: Icons.chat_bubble_rounded,
                  label: 'Chat',
                  isActive: _currentIndex == 1,
                  onTap: () => setState(() => _currentIndex = 1),
                  showDot: true,
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Profile',
                  isActive: _currentIndex == 2,
                  onTap: () => setState(() => _currentIndex = 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.showDot = false,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isActive ? activeIcon : icon,
                    key: ValueKey(isActive),
                    size: 24,
                    color: isActive
                        ? const Color(0xFF34ACB7)
                        : Colors.grey.shade400,
                  ),
                ),
                if (showDot && !isActive)
                  Positioned(
                    right: -4,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF7A5C),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? const Color(0xFF34ACB7)
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
