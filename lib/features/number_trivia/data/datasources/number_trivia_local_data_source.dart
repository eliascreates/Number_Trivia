import 'package:examplenumbertrivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  ///Gets cached [NumberTriviaModel] which was retrieved the last time the user had internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  ///caches the current [NumberTriviaModel] 
  ///
  /// Throws [CacheException] if unable to cache [NumberTriviaModel] 
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}
