import 'package:examplenumbertrivia/core/error/failures.dart';
import 'package:examplenumbertrivia/core/usecases/usecase.dart';
import 'package:examplenumbertrivia/core/util/input_converter.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
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

  const testNumberString = '1';
  const testNumberParsed = 1;
  void setUpMockInputConverterSuccess() {
    when(mockInputConverter.stringtoUnsignedInt(testNumberString))
        .thenReturn(const Right(testNumberParsed));
  }

  blocTest(
    'should emit [] which represents [NumberTriviaInitial] when the bloc is instantiated',
    build: () => bloc,
    expect: () => [],
    verify: (bloc) => bloc.state is NumberTriviaInitial,
  );

  group('NumberTriviaConcreteFetched', () {
    const testNumberTrivia = NumberTrivia(
      text: 'test text',
      number: testNumberParsed,
    );

    blocTest(
      'should call the InputConverter to validate and convert the string into an unsigned integer',
      build: () {
        setUpMockInputConverterSuccess();
        when((mockGetConcreteNumberTrivia(
                const Params(number: testNumberParsed))))
            .thenAnswer(
          (_) async => const Right(testNumberTrivia),
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
      'should get data from the concrete usecase',
      build: () {
        setUpMockInputConverterSuccess();

        when((mockGetConcreteNumberTrivia(
                const Params(number: testNumberParsed))))
            .thenAnswer(
          (_) async => const Right(testNumberTrivia),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
          const NumberTriviaConcreteFetched(numberString: testNumberString)),
      verify: (bloc) =>
          mockGetConcreteNumberTrivia(const Params(number: testNumberParsed)),
    );

    blocTest(
      'should emit [NumberTriviaLoadInProgress, NumberTriviaLoadSuccess] when the input is valid',
      build: () {
        setUpMockInputConverterSuccess();
        when((mockGetConcreteNumberTrivia(
                const Params(number: testNumberParsed))))
            .thenAnswer(
          (_) async => const Right(testNumberTrivia),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
          const NumberTriviaConcreteFetched(numberString: testNumberString)),
      expect: () => [
        const NumberTriviaLoadInProgress(),
        const NumberTriviaLoadSuccess(numberTrivia: testNumberTrivia)
      ],
    );

    blocTest(
      'should emit [NumberTriviaLoadInProgress, NumberTriviaLoadFailure] when a Server Failure is returned',
      build: () {
        setUpMockInputConverterSuccess();
        when((mockGetConcreteNumberTrivia(
                const Params(number: testNumberParsed))))
            .thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(
          const NumberTriviaConcreteFetched(numberString: testNumberString)),
      expect: () => [
        const NumberTriviaLoadInProgress(),
        const NumberTriviaLoadFailure(errorMessage: serverFailureMessage),
      ],
    );
    blocTest(
      'should emit [NumberTriviaLoadInProgress, NumberTriviaLoadFailure] when a Cache Failure is returned',
      build: () {
        setUpMockInputConverterSuccess();
        when((mockGetConcreteNumberTrivia(
                const Params(number: testNumberParsed))))
            .thenAnswer((_) async => const Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(
          const NumberTriviaConcreteFetched(numberString: testNumberString)),
      expect: () => [
        const NumberTriviaLoadInProgress(),
        const NumberTriviaLoadFailure(errorMessage: cacheFailureMessage),
      ],
    );
  });

  group('NumberTriviaRandomFetched', () {

    const testNumberTrivia = NumberTrivia(
      text: 'test text',
      number: 1,
    );


    blocTest(
      'should get data from the random usecase',
      build: () {

        when((mockGetRandomNumberTrivia(const NoParams()))).thenAnswer(
          (_) async => const Right(testNumberTrivia),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const NumberTriviaRandomFetched()),
      verify: (bloc) => mockGetRandomNumberTrivia(const NoParams()),
    );

    blocTest(
      'should emit [NumberTriviaLoadInProgress, NumberTriviaLoadFailure] when a Server Failure is returned',
      build: () {
        when((mockGetRandomNumberTrivia(const NoParams())))
            .thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const NumberTriviaRandomFetched()),
      expect: () => [
        const NumberTriviaLoadInProgress(),
        const NumberTriviaLoadFailure(errorMessage: serverFailureMessage),
      ],
    );
    blocTest(
      'should emit [NumberTriviaLoadInProgress, NumberTriviaLoadFailure] when a Cache Failure is returned',
      build: () {
        when((mockGetRandomNumberTrivia(const NoParams())))
            .thenAnswer((_) async => const Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const NumberTriviaRandomFetched()),
      expect: () => [
        const NumberTriviaLoadInProgress(),
        const NumberTriviaLoadFailure(errorMessage: cacheFailureMessage),
      ],
    );
  });
}
