part of 'top_trivia_description.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({super.key, required this.numberTrivia});

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          numberTrivia.number.toString(),
          style: textTheme.titleLarge,
          textScaleFactor: 1.5,
        ),
        const SizedBox(height: 20),
        Expanded(child: MessageDisplay(message: numberTrivia.text)),
      ],
    );
  }
}
