import 'dart:ui';

class Question {
  final String questionText;
  final String questionImage;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.questionText,
    required this.questionImage,
    required this.options,
    required this.correctOptionIndex,
  });
}