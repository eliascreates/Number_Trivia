import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:examplenumbertrivia/core/error/exceptions.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import './number_trivia_remote_data_source_test.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([MockHttpClient])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockMockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockMockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testNumber = 1;

  void setUpMockHttpClientSuccess200({required bool isConcreteMethod}) {
    if (isConcreteMethod) {
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$testNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    } else {
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    }
  }

  void setUpMockHttpClientFailure404({required bool isConcreteMethod}) {
    if (isConcreteMethod) {
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$testNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));
    } else {
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));
    }
  }

  group('getConcreteNumberTrivia', () {
    final testNumberTrivia = NumberTriviaModel.fromJson(
      jsonDecode(fixture('trivia.json')),
    );
    test(
        'should perform a GET request with a number being the endpoint and with application/json header',
        () {
      //Arrange
      setUpMockHttpClientSuccess200(isConcreteMethod: true);
      //Act
      dataSource.getConcreteNumberTrivia(testNumber);

      //Assert
      verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/$testNumber'),
          headers: {'Content-Type': 'application/json'}));
    });
    test(
        'should return a valid NumberTriviaModel when the status code is 200 (success)',
        () async {
      //Arrange
      setUpMockHttpClientSuccess200(isConcreteMethod: true);

      //Act
      final result = await dataSource.getConcreteNumberTrivia(testNumber);

      //Assert
      expect(result, testNumberTrivia);
    });

    test(
        'should throw ServerException when the status code is not 200 (unsuccessful)',
        () async {
      //Arrange
      setUpMockHttpClientFailure404(isConcreteMethod: true);
      //Act
      final call = dataSource.getConcreteNumberTrivia;

      //Assert
      expect(() => call(testNumber),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('getRandomNumberTrivia', () {
    final testNumberTrivia = NumberTriviaModel.fromJson(
      jsonDecode(fixture('trivia.json')),
    );
    test(
        'should perform a GET request with a number being the endpoint and with application/json header',
        () {
      //Arrange
      setUpMockHttpClientSuccess200(isConcreteMethod: false);
      //Act
      dataSource.getRandomNumberTrivia();

      //Assert
      verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'}));
    });
    test(
        'should return a valid NumberTriviaModel when the status code is 200 (success)',
        () async {
      //Arrange
      setUpMockHttpClientSuccess200(isConcreteMethod: false);

      //Act
      final result = await dataSource.getRandomNumberTrivia();

      //Assert
      expect(result, testNumberTrivia);
    });

    test(
        'should throw ServerException when the status code is not 200 (unsuccessful)',
        () async {
      //Arrange
      setUpMockHttpClientFailure404(isConcreteMethod: false);
      
      //Act
      final call = dataSource.getRandomNumberTrivia;

      //Assert
      expect(() => call(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
