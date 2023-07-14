part of 'bottom_trivia_interactions.dart';

final class _TriviaSearchSubmitButton extends StatelessWidget {
  const _TriviaSearchSubmitButton({required this.onPress});

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('bottomTriviaInteractions_getConcrete_elevatedButton'),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Search'),
    );
  }
}