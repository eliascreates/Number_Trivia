// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:examplenumbertrivia/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  ///caches the current [NumberTriviaModel]
  ///
  /// Throws [CacheException] if unable to cache [NumberTriviaModel]
  ///
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);

  ///Gets cached [NumberTriviaModel] which was retrieved the last time the user had internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();
}

const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);

    if (jsonString != null) {
      final numberTrivia = NumberTriviaModel.fromJson(jsonDecode(jsonString));

      return Future.value(numberTrivia);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {

    final numberTriviaToJson = jsonEncode(triviaToCache.toJson());

    final isSuccessful = await sharedPreferences.setString(
      cachedNumberTrivia,
      numberTriviaToJson,
    );

    if (isSuccessful) return;
    throw CacheException();
  }
}
