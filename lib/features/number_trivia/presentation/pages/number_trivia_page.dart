import 'package:examplenumbertrivia/core/util/input_converter.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:examplenumbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:examplenumbertrivia/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider<NumberTriviaBloc>(
        create: (context) => NumberTriviaBloc(
          concrete: sl<GetConcreteNumberTrivia>(),
          random: sl<GetRandomNumberTrivia>(),
          inputConverter: sl<InputConverter>(),
        ),
        child: const NumberTriviaView(),
      ),
    );
  }
}

class NumberTriviaView extends StatelessWidget {
  const NumberTriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //* TOP HALF
        /* const  */ Expanded(flex: 2, child: TopTriviaDescription()),
        /* const  */ SizedBox(height: 20),
        //* BOTTOM HALF
        /* const  */ Expanded(flex: 1, child: BottomTriviaInteractions()),
      ],
    );
  }
}
