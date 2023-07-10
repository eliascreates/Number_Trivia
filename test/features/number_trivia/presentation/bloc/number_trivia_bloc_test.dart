import 'package:examplenumbertrivia/core/util/input_converter.dart';
// import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import './number_trivia_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late MockInputConverter mockInputConverter;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late NumberTriviaBloc bloc;

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();

    bloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  blocTest(
    'should emit [NumberTriviaInitial] when the bloc is instantiated',
    build: () => bloc,
    verify: (bloc) => bloc.state is NumberTriviaInitial,
  );

  group('NumberTriviaConcreteFetched', () {
    const testNumberString = '1';
    const testNumberParsed = 1;
    // final testNumberTrivia = NumberTrivia(text: 'test text', number: 1);

    blocTest(
      'should call the InputConverter to validate and convert the string into an unsigned integer',
      build: () {
        when(mockInputConverter.stringtoUnsignedInt(testNumberString))
            .thenReturn(
          const Right(testNumberParsed),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
          const NumberTriviaConcreteFetched(numberString: testNumberString)),
      verify: (_) => mockInputConverter.stringtoUnsignedInt(testNumberString),
    );

    blocTest(
      'should emit [NumberTriviaLoadFailure] when the input is invalid',
      build: () {
        when(mockInputConverter.stringtoUnsignedInt(testNumberString))
            .thenReturn(const Left(InvalidInputFailure()));

        return bloc;
      },
      act: (bloc) => bloc.add(
          const NumberTriviaConcreteFetched(numberString: testNumberString)),
      expect: () => [
        const NumberTriviaLoadFailure(errorMessage: invalidInputFailureMessage)
      ],
    );

    blocTest(
      'should emit [NumberTriviaLoadSuccess] when the input is valid',
      build: () {
        when(mockInputConverter.stringtoUnsignedInt(testNumberString))
            .thenReturn(const Right(testNumberParsed));
        return bloc;
      },
    );
  });
}
