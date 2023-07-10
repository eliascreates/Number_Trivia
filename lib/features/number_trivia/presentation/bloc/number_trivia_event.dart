// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

final class NumberTriviaConcreteFetched extends NumberTriviaEvent {
  final String number;
  const NumberTriviaConcreteFetched({required this.number});

  @override
  List<Object> get props => [number];
}

final class NumberTriviaRandomFetched extends NumberTriviaEvent {}
