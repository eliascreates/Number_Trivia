import 'package:dartz/dartz.dart';
import 'package:examplenumbertrivia/core/error/failures.dart';
import 'package:examplenumbertrivia/core/usecases/usecase.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams> {
  const GetRandomNumberTrivia(this.numberTriviaRepository);

  final NumberTriviaRepository numberTriviaRepository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}


