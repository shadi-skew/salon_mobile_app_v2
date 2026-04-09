import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:salon_mobile_app_v2/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}
