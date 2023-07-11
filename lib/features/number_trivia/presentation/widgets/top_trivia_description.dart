import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:examplenumbertrivia/core/constants/strings.dart';

import '../../domain/entities/number_trivia.dart';
import '../bloc/number_trivia_bloc.dart';

part 'message_display.dart';
part 'trivia_display.dart';

class TopTriviaDescription extends StatelessWidget {
  const TopTriviaDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).copyWith(top: 20),
      child: Center(
        child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
          builder: (context, state) {
            if (state is NumberTriviaLoadInProgress) {
              return const CircularProgressIndicator();
            } else if (state is NumberTriviaLoadSuccess) {
              return TriviaDisplay(numberTrivia: state.numberTrivia);
            } else if (state is NumberTriviaLoadFailure) {
              return MessageDisplay(message: state.errorMessage);
            } else if (state is NumberTriviaInitial) {
              return const MessageDisplay(message: Strings.newMessage);
            }
            return const Text("Welcome");
          },
        ),
      ),
    );
  }
}
