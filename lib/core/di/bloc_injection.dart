import 'package:injectable/injectable.dart';
import 'package:salon_mobile_app_v2/features/sample/domain/use_cases/get_sample_items_usecase.dart';
import 'package:salon_mobile_app_v2/features/sample/presentation/manager/sample_bloc.dart';

/// Dependency injection module for BLoCs and Cubits
/// Add your feature BLoCs here
@module
abstract class BlocInjection {
  @singleton
  SampleBloc sampleBloc(GetSampleItemsUseCase getSampleItemsUseCase) =>
      SampleBloc(getSampleItemsUseCase);
}
