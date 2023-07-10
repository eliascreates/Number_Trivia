import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringtoUnsignedInt(String str) {
    try {
      final int result = int.parse(str);

      if (result < 0) throw const FormatException();

      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
