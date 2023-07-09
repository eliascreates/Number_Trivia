import 'package:dartz/dartz.dart';
import 'package:examplenumbertrivia/core/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import './number_trivia_repository_test.mocks.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  group(
    'Random NumberTrivia tests: ',
    () {
      late MockMockNumberTriviaRepository mockNumberTriviaRepository;
      late GetRandomNumberTrivia usecase;

      setUp(() {
        mockNumberTriviaRepository = MockMockNumberTriviaRepository();
        usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
      });

      const testNumber = 1;
      const testNumberTrivia =
          NumberTrivia(number: testNumber, text: 'Do something new');

      test(
        'should get random number trivia when usecase is called',
        () async {
          //Arrange
          when(mockNumberTriviaRepository.getRandomNumberTrivia())
              .thenAnswer((_) async => const Right(testNumberTrivia));

          //Act
          final result = await usecase(const NoParams());

          //Assert
          expect(result, const Right(testNumberTrivia));
          verify(mockNumberTriviaRepository.getRandomNumberTrivia());
          verifyNoMoreInteractions(mockNumberTriviaRepository);
        },
      );
    },
  );
}
