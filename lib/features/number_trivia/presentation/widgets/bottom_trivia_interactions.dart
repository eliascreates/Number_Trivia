import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(20).copyWith(bottom: 0),
      alignment: Alignment.topCenter,
      color: Colors.green.shade300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            onChanged: (value) => numberString = value,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Enter a number',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _TriviaSearchSubmitButton(text: numberString)),
              const SizedBox(width: 20),
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

class _TriviaRandomButton extends StatelessWidget {
  const _TriviaRandomButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: const Key('bottomTriviaInteractions_getRandom_elevatedButton'),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.shuffle),
      label: const Text('Random'),
    );
  }
}

class _TriviaSearchSubmitButton extends StatelessWidget {
  const _TriviaSearchSubmitButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('bottomTriviaInteractions_getConcrete_elevatedButton'),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Search'),
    );
  }
}
