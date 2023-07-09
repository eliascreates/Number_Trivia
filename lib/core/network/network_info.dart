import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker dataConnectionChecker;

  NetworkInfoImpl({required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
