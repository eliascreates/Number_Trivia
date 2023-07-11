import 'package:flutter/material.dart';

import 'package:examplenumbertrivia/features/number_trivia/presentation/pages/number_trivia_page.dart';

import 'injector_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const NumberTriviaPage(),
    );
  }
}
