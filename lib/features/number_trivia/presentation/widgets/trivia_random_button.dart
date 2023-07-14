part of 'bottom_trivia_interactions.dart';

final class _TriviaRandomButton extends StatelessWidget {
  const _TriviaRandomButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: const Key('bottomTriviaInteractions_getRandom_elevatedButton'),
      onPressed: () => context
          .read<NumberTriviaBloc>()
          .add(const NumberTriviaRandomFetched()),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.shuffle),
      label: const Text('Random'),
    );
  }
}