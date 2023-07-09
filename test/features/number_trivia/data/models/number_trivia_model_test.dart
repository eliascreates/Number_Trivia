import 'dart:convert';

import 'package:examplenumbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');
  test(
      'Given Number Trivia model When instantiated Then it is a subtype of NumberTrivia',
      () {
    //Assert
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });

  group('NumberTriviaModel.fromJson -', () {
    test(
        'Should return a valid number trivia model When the Json number is an integer.',
        () {
      //Arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));

      //Act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //Assert
      expect(result, testNumberTriviaModel);
    });
    test(
        'Should return a valid number trivia model When the Json number is regarded as a double.',
        () {
      //Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('trivia_double.json'));

      //Act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //Assert
      expect(result, testNumberTriviaModel);
    });
  });

  group('NumberTrivia.toJson', () {
    test('Should return a Json map containing the proper data', () {
      //Act
      final result = testNumberTriviaModel.toJson();

      final expectedMap = {
        "text": "test text",
        "number": 1,
      };

      //Assert

      expect(result, expectedMap);
    });
  });
}
