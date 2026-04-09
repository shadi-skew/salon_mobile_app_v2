import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_mobile_app_v2/bloc_observer.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/core/resources/routes_manager.dart';
import 'package:salon_mobile_app_v2/core/resources/theme_manager.dart';
import 'package:salon_mobile_app_v2/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManager.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorManager.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await configureDependencies();

  Bloc.observer = const AppBlocObserver();
  runApp(const SalonApp());
}

class SalonApp extends StatefulWidget {
  const SalonApp({super.key});

  @override
  State<SalonApp> createState() => _SalonAppState();
}

class _SalonAppState extends State<SalonApp> {
  final RoutesManager routesManager = RoutesManager();

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, widget) => MaterialApp.router(
      title: 'Salon App',
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: getApplicationThemeData(),
      routerConfig: routesManager.router,
    ),
  );
}
