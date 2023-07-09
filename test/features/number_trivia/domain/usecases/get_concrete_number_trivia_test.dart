import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import './number_trivia_repository_test.mocks.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  group('Concrete NumberTrivia tests: ', () {
    late MockMockNumberTriviaRepository mockNumberTriviaRepository;
    late GetConcreteNumberTrivia usecase;

    setUp(() {
      mockNumberTriviaRepository = MockMockNumberTriviaRepository();
      usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    });

    const testNumber = 1;
    const testNumberTrivia =
        NumberTrivia(number: testNumber, text: 'test text');

    test(
      'should get concrete number trivia when the use case is called',
      () async {
        //Arrange
        when(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber))
            .thenAnswer((_) async => const Right(testNumberTrivia));

        //Act
        final result = await usecase(const Params(number: testNumber));

        //Assert
        expect(result, const Right(testNumberTrivia));
        verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      },
    );
  });
}
