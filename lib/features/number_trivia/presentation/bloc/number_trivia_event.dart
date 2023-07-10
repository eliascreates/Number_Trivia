// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

final class NumberTriviaConcreteFetched extends NumberTriviaEvent {
  final String numberString;
  const NumberTriviaConcreteFetched({required this.numberString});

  @override
  List<Object> get props => [numberString];
}

final class NumberTriviaRandomFetched extends NumberTriviaEvent {
  const NumberTriviaRandomFetched();
}
