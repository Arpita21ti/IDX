// The Question model to handle the incoming questions from the server.
class Question {
  final String id;
  final String title;
  final String description;

  Question({required this.id, required this.title, required this.description});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
