import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';

class InterviewPrepScreen extends StatelessWidget {
  const InterviewPrepScreen({super.key});

  // Question Bank: Replace this with your data source.
  final List<Map<String, String>> questionBank = const [
    {
      "question": "Explain the difference between an array and a linked list.",
      "answer":
          "Array: A contiguous block of memory locations used to store elements of the same data type. Access to elements is direct, using an index.\nLinked List: A linear data structure where elements are not stored contiguously. Each element, a node, contains data and a reference (pointer) to the next node. Access to elements is sequential, starting from the head node."
    },
    {
      "question": "What is a widget?",
      "answer": "A widget is a basic building block of a Flutter app's UI."
    },
    {
      "question": "What is Dart?",
      "answer": "Dart is a programming language used to develop Flutter apps."
    },
    {
      "question": "What is state management?",
      "answer":
          "State management refers to handling the state of the app efficiently."
    },
    {
      "question": "What is a StatelessWidget?",
      "answer": "A widget that does not require mutable state."
    },
    {
      "question": "What is a StatefulWidget?",
      "answer": "A widget that has mutable state and can be updated."
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Shuffle questions to display them randomly
    final randomQuestions = List<Map<String, String>>.from(questionBank)
      ..shuffle(Random());

    return MyScaffold(
      appBarTitle: 'Interview Prep',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: randomQuestions.length,
            itemBuilder: (context, index) {
              final question = randomQuestions[index]["question"]!;
              final answer = randomQuestions[index]["answer"]!;
              return _buildQuestionTile(question, answer);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTile(String question, String answer) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
