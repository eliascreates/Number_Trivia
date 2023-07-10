// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {
  const NumberTriviaInitial();
}

class NumberTriviaLoadInProgress extends NumberTriviaState {
  const NumberTriviaLoadInProgress();
}

class NumberTriviaLoadSuccess extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  const NumberTriviaLoadSuccess({required this.numberTrivia});

  @override
  List<Object> get props => [numberTrivia];
}

class NumberTriviaLoadFailure extends NumberTriviaState {
  final String errorMessage;
  const NumberTriviaLoadFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
