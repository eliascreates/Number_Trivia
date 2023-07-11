import 'package:flutter/material.dart';

class BottomTriviaInteractions extends StatelessWidget {
  const BottomTriviaInteractions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 40),
      alignment: Alignment.bottomCenter,
      color: Colors.green.shade300,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Placeholder(fallbackHeight: 40),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Placeholder(
                  fallbackHeight: 40,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Placeholder(
                  fallbackHeight: 40,
                ),
              )
            ],
          )

          // const Center(
          //   child: Text("Number Trivia"),
          // ),
        ],
      ),
    );
  }
}
