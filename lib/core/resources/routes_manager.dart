import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/pages/ai_stylist_page.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/pages/hairstyle_detail_page.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/pages/style_result_page.dart';
import 'package:salon_mobile_app_v2/features/root/presentation/pages/root_page.dart';

// Export root navigator key for global navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();

class RoutesManager {
  RoutesManager() {
    _appRouter = GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: AppRoutesNames.root,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const RootPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/ai-stylist',
          name: AppRoutesNames.aiStylist,
          pageBuilder: (context, state) {
            return CupertinoPage(
              child: const AiStylistPage(),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/hairstyle-detail',
          name: AppRoutesNames.hairstyleDetail,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            return CupertinoPage(
              child: HairstyleDetailPage(
                title: extra['title'] as String? ?? 'Styles',
                cardCount: extra['cardCount'] as int?,
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
        GoRoute(
          path: '/style-result',
          name: AppRoutesNames.styleResult,
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            return CupertinoPage(
              child: StyleResultPage(
                title: extra['title'] as String? ?? 'Styles',
                imagePath: extra['imagePath'] as String? ?? '',
                cardCount: extra['cardCount'] as int?,
              ),
              key: state.pageKey,
              name: state.name,
            );
          },
        ),
      ],
    );
  }

  late final GoRouter _appRouter;
  GoRouter get router => _appRouter;
}
