import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salon_mobile_app_v2/core/resources/app_routes_names.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/pages/ai_stylist_page.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/pages/hairstyle_detail_page.dart';
import 'package:salon_mobile_app_v2/features/ai_stylist/presentation/pages/style_result_page.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/formula.dart';
import 'package:salon_mobile_app_v2/features/formulas/domain/entities/timer_session.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/domain/formula/formula_cubit.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/pages/formula_calculator/formula_calculator_page.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/pages/formula_calculator/formula_results_page.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/pages/my_formulas_page.dart';
import 'package:salon_mobile_app_v2/features/formulas/presentation/pages/timer/timer_detail_page.dart';
import 'package:salon_mobile_app_v2/features/root/presentation/pages/root_page.dart';

// Export root navigator key so it can be used for imperative navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();

class RoutesManager {
  RoutesManager() {
    _appRouter = GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: AppRoutesNames.root,
      routes: [
        // ─── Root ───────────────────────────────────────────────────────────
        GoRoute(
          path: AppRoutesNames.root,
          name: AppRoutesNames.root,
          pageBuilder: (context, state) => CupertinoPage(
            key: state.pageKey,
            name: state.name,
            child: const RootPage(),
          ),
        ),

        GoRoute(
          path: AppRoutesNames.myFormulasPath,
          name: AppRoutesNames.myFormulas,
          pageBuilder: (context, state) => CupertinoPage(
            key: state.pageKey,
            name: state.name,
            child: const MyFormulasPage(),
          ),
        ),
        GoRoute(
          path: AppRoutesNames.formulaCalculatorPath,
          name: AppRoutesNames.formulaCalculator,
          pageBuilder: (context, state) => CupertinoPage(
            key: state.pageKey,
            name: state.name,
            child: BlocProvider(
              create: (_) => FormulaCubit(),
              child: const FormulaCalculatorPage(),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutesNames.formulaResultsPath,
          name: AppRoutesNames.formulaResults,
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>? ?? const {};
            return CupertinoPage(
              key: state.pageKey,
              name: state.name,
              child: FormulaResultsPage(
                currentLevel: args['currentLevel'] as int? ?? 5,
                targetLevel: args['targetLevel'] as int? ?? 5,
                brand: args['brand'] as HairBrand? ?? HairBrand.wella,
                onFormulaCommitted:
                    args['onFormulaCommitted'] as void Function(Formula)?,
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutesNames.timerDetailPath,
          name: AppRoutesNames.timerDetail,
          pageBuilder: (context, state) {
            final session = state.extra as TimerSession?;
            return CupertinoPage(
              key: state.pageKey,
              name: state.name,
              child: session != null
                  ? TimerDetailPage(session: session)
                  : const Scaffold(
                      body: Center(child: Text('No timer session provided.')),
                    ),
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
