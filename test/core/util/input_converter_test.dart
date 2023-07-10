import 'package:examplenumbertrivia/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () {
      //Arrange
      const str = '123';
      //Act
      final result = inputConverter.stringtoUnsignedInt(str);
      //Assert
      expect(result, const Right(123));
    });

    test(
        'should return InvalidInputFailure when the string represents an invalid integer',
        () {
      //Arrange
      const str = '1bc';
      //Act
      final result = inputConverter.stringtoUnsignedInt(str);

      //Assert
      expect(result, Left(InvalidInputFailure()));
    });
    test(
        'should return InvalidInputFailure when the string represents a negative integer ',
        () {
      //Arrange
      const str = '-123';
      //Act
      final result = inputConverter.stringtoUnsignedInt(str);

      //Assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
