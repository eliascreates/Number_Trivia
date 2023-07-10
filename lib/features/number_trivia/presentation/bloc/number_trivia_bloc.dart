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

    emit(
      inputEither.fold(
          (l) => const NumberTriviaLoadFailure(
              errorMessage: invalidInputFailureMessage),
          (r) => throw UnimplementedError()),
    );
  }

  Future<void> _onNumberTriviaRandom(
    NumberTriviaRandomFetched event,
    Emitter<NumberTriviaState> emit,
  ) async {
    // TODO: implement event handler
  }
}
