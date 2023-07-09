import 'package:dartz/dartz.dart';
import 'package:examplenumbertrivia/core/error/exceptions.dart';
import 'package:examplenumbertrivia/core/error/failures.dart';
import 'package:examplenumbertrivia/core/network/network_info.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:examplenumbertrivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import './number_trivia_repository_impl_test.mocks.dart';

import 'package:mockito/mockito.dart';

class MockNumberTriviaRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockNumberTriviaLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockMockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockMockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockMockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNumberTriviaRemoteDataSource = MockMockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockMockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockMockNetworkInfo();

    repository = NumberTriviaRepositoryImpl(
      numberTriviaRemoteDataSource: mockNumberTriviaRemoteDataSource,
      numberTriviaLocalDataSource: mockNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', () {
    const testNumber = 1;
    const testNumberTriviaModel =
        NumberTriviaModel(text: 'test text', number: testNumber);

    const NumberTrivia testNumberTrivia = testNumberTriviaModel;

    test('should check if the device is online', () async {
      //Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //Act
      await repository.networkInfo.isConnected;
      //Assert
      verify(mockNetworkInfo.isConnected);
    });
    test('should check if the device is offline', () async {
      //Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      //Act
      await repository.networkInfo.isConnected;
      //Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data is successsful',
          () async {
        //Arrange
        when(mockNumberTriviaRemoteDataSource
                .getConcreteNumberTrivia(testNumber))
            .thenAnswer((_) async => testNumberTriviaModel);
        //Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        //Assert

        expect(result, equals(const Right(testNumberTrivia)));

        verify(mockNumberTriviaRemoteDataSource
            .getConcreteNumberTrivia(testNumber));
      });
      test(
          'should cache data locally when the call to remote data is successsful',
          () async {
        //Arrange
        when(mockNumberTriviaRemoteDataSource
                .getConcreteNumberTrivia(testNumber))
            .thenAnswer((_) async => testNumberTriviaModel);
        //Act
        await repository.getConcreteNumberTrivia(testNumber);
        //Assert
        verify(mockNumberTriviaRemoteDataSource
            .getConcreteNumberTrivia(testNumber));

        verify(mockNumberTriviaLocalDataSource
            .cacheNumberTrivia(testNumberTriviaModel));
      });
      test(
          'should return server failure when the call to remote data is unsuccesssful',
          () async {
        //Arrange
        when(mockNumberTriviaRemoteDataSource
                .getConcreteNumberTrivia(testNumber))
            .thenThrow(ServerException());
        //Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        //Assert

        verifyZeroInteractions(mockNumberTriviaLocalDataSource);

        verify(mockNumberTriviaRemoteDataSource
            .getConcreteNumberTrivia(testNumber));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return local data when the call to local data is present',
          () async {
        //Arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        //Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        //Assert
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        expect(result, equals(const Right(testNumberTrivia)));
      });
      test(
          'should return cache failure when the call to local data is not present',
          () async {
        //Arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        //Assert

        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);

        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    const testNumberTriviaModel =
        NumberTriviaModel(text: 'test text', number: 1);

    const NumberTrivia testNumberTrivia = testNumberTriviaModel;

    test('should check if the device is online', () async {
      //Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //Act
      await repository.networkInfo.isConnected;
      //Assert
      verify(mockNetworkInfo.isConnected);
    });
    test('should check if the device is offline', () async {
      //Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      //Act
      await repository.networkInfo.isConnected;
      //Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data is successsful',
          () async {
        //Arrange
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        //Act
        final result = await repository.getRandomNumberTrivia();
        //Assert

        expect(result, equals(const Right(testNumberTrivia)));

        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
      });
      test(
          'should cache data locally when the call to remote data is successsful',
          () async {
        //Arrange
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        //Act
        await repository.getRandomNumberTrivia();
        //Assert
        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());

        verify(mockNumberTriviaLocalDataSource
            .cacheNumberTrivia(testNumberTriviaModel));
      });
      test(
          'should return server failure when the call to remote data is unsuccesssful',
          () async {
        //Arrange
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //Act
        final result = await repository.getRandomNumberTrivia();
        //Assert

        verifyZeroInteractions(mockNumberTriviaLocalDataSource);

        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return local data when the call to local data is present',
          () async {
        //Arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        //Act
        final result = await repository.getRandomNumberTrivia();
        //Assert
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        expect(result, equals(const Right(testNumberTrivia)));
      });
      test(
          'should return cache failure when the call to local data is not present',
          () async {
        //Arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //Act
        final result = await repository.getRandomNumberTrivia();
        //Assert

        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);

        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
