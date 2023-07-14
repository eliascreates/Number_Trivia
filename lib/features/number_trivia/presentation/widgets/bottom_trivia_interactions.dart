import 'package:examplenumbertrivia/core/constants/k_values.dart';
import 'package:examplenumbertrivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trivia_search_submit_button.dart';
part 'trivia_random_button.dart';

class BottomTriviaInteractions extends StatefulWidget {
  const BottomTriviaInteractions({super.key});

  @override
  State<BottomTriviaInteractions> createState() =>
      _BottomTriviaInteractionsState();
}

class _BottomTriviaInteractionsState extends State<BottomTriviaInteractions> {
  late TextEditingController _textEditingController;
  String numberString = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KValues.defaultPadding).copyWith(bottom: 0),
      alignment: Alignment.topCenter,
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            onChanged: (value) => numberString = value,
            onSubmitted: (text) => context
                .read<NumberTriviaBloc>()
                .add(NumberTriviaConcreteFetched(numberString: text)),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(KValues.defaultPadding / 2)),
              hintText: 'Enter a number',
            ),
          ),
          const SizedBox(height: KValues.defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _TriviaSearchSubmitButton(
                  onPress: () {
                    _textEditingController.clear();
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); //Drops the keyboard
                    if (numberString.isNotEmpty) {
                      context.read<NumberTriviaBloc>().add(
                            NumberTriviaConcreteFetched(
                                numberString: numberString),
                          );
                    }
                    numberString = '';
                  },
                ),
              ),
              const SizedBox(width: KValues.defaultPadding),
              const Expanded(
                child: _TriviaRandomButton(),
              )
            ],
          )
        ],
      ),
    );
  }
}
