import 'dart:convert';

import 'package:examplenumbertrivia/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './number_trivia_local_data_source_test.mocks.dart';

import 'package:examplenumbertrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

@GenerateMocks([MockSharedPreferences])
void main() {
  late MockMockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockMockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('trivia_cached.json'));
    final testNumberTriviaModel = NumberTriviaModel.fromJson(jsonMap);
    test(
        'Should return NumberTriviaModel from sharedPreferences when there is one in cache',
        () async {
      //Arrange
      when(mockSharedPreferences.getString(cachedNumberTrivia))
          .thenReturn(fixture('trivia_cached.json'));
      //Act
      final result = await dataSource.getLastNumberTrivia();
      //Assert
      verify(mockSharedPreferences.getString(cachedNumberTrivia));
      expect(result, equals(testNumberTriviaModel));
    });
    test('Should throw CacheException when there is no in cached number trivia',
        () async {
      //Arrange
      when(mockSharedPreferences.getString(cachedNumberTrivia))
          .thenReturn(null);
      //Act
      final call = dataSource.getLastNumberTrivia;
      //Assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheTriviaModel', () {
    const testNumberTriviaModel =
        NumberTriviaModel(text: 'test text', number: 1);

    test('Should call sharedPreferences to cache the data', () {
      //arrange
      when(mockSharedPreferences.setString(
        cachedNumberTrivia,
        jsonEncode(testNumberTriviaModel.toJson()),
      )).thenAnswer((_) async => true);

      //Act
      dataSource.cacheNumberTrivia(testNumberTriviaModel);

      final expectedJsonString = jsonEncode(testNumberTriviaModel.toJson());
      //Assert
      verify(mockSharedPreferences.setString(
          cachedNumberTrivia, expectedJsonString));
    });
  });
}
