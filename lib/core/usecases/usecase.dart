import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, NumberTrivia>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}