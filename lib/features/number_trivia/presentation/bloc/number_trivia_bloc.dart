import 'package:dartz/dartz.dart';
import 'package:examplenumbertrivia/core/error/failures.dart';
import 'package:examplenumbertrivia/core/usecases/usecase.dart';
import 'package:examplenumbertrivia/core/util/input_converter.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';
const String cacheFailureMessage = 'Server Failure';
const String serverFailureMessage = 'Cache Failure';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(const NumberTriviaInitial()) {
    on<NumberTriviaConcreteFetched>(_onNumberTriviaConcrete);
    on<NumberTriviaRandomFetched>(_onNumberTriviaRandom);
  }

  Future<void> _onNumberTriviaConcrete(
    NumberTriviaConcreteFetched event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final inputEither = inputConverter.stringtoUnsignedInt(event.numberString);

    inputEither.fold(
      (failure) => emit(const NumberTriviaLoadFailure(
          errorMessage: invalidInputFailureMessage)),
      (integer) async {
        emit(const NumberTriviaLoadInProgress());
        final concreteOrFailure =
            await getConcreteNumberTrivia(Params(number: integer));

        _loadSuccessOrFailureState(concreteOrFailure, emit);
      },
    );
  }

  Future<void> _onNumberTriviaRandom(
    NumberTriviaRandomFetched event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(const NumberTriviaLoadInProgress());
    final randomOrFailure = await getRandomNumberTrivia(const NoParams());

    _loadSuccessOrFailureState(randomOrFailure, emit);
  }

  void _loadSuccessOrFailureState(
      Either<Failure, NumberTrivia> concreteOrFailure,
      Emitter<NumberTriviaState> emit) {
    return concreteOrFailure.fold(
      (failure) => emit(NumberTriviaLoadFailure(errorMessage: failure.message)),
      (numberTrivia) => emit(
        NumberTriviaLoadSuccess(numberTrivia: numberTrivia),
      ),
    );
  }
}

extension _MapFailureToMessage on Failure {
  String get message {
    switch (this) {
      case ServerFailure():
        return serverFailureMessage;
      case CacheFailure():
        return cacheFailureMessage;
      default:
        return "Unexpected Error";
    }
  }
}
