import 'package:examplenumbertrivia/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';


class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  group('DataConnectionChecker - ', () {
    late MockMockDataConnectionChecker mockDataConnectionChecker;
    late NetworkInfoImpl networkInfo;

    setUp(() {
      mockDataConnectionChecker = MockMockDataConnectionChecker();
      networkInfo = NetworkInfoImpl(dataConnectionChecker: mockDataConnectionChecker);
    });

    test('Should forward the call to  DataConnectionChecker.hasConnection ',
        () {
      //Arrange
      final testHasConnectionFuture = Future.value(true);

      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => testHasConnectionFuture);

      //Act
      final result = networkInfo.isConnected;

      //Assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, testHasConnectionFuture);
    });
  });
}
