part of 'top_trivia_description.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({super.key, required this.numberTrivia});

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            numberTrivia.number.toString(),
            style: textTheme.titleLarge,
            textScaleFactor: KValues.textScaleFactor,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: KValues.defaultPadding),
          Expanded(child: MessageDisplay(message: numberTrivia.text)),
        ],
      ),
    );
  }
}
