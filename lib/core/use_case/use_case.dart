import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:salon_mobile_app_v2/core/errors/network_exceptions.dart';

abstract class UseCase<Entity, Params> {
  Future<Either<NetworkExceptions, Entity>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
