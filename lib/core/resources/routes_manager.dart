import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
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
        // Add more routes here as you build features
      ],
    );
  }

  late final GoRouter _appRouter;
  GoRouter get router => _appRouter;
}
