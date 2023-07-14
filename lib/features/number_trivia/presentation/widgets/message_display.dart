part of 'top_trivia_description.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Text(
        message,
        style: textTheme.bodyMedium,
        textScaleFactor: KValues.textScaleFactor,
        textAlign: TextAlign.center,
      ),
    );
  }
}
