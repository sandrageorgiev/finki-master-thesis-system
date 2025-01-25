class Thesis {
  final String id;
  final String title;
  final String student;
  final String description;

  Thesis({
    required this.id,
    required this.title,
    required this.student,
    required this.description,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'],
      title: json['title'],
      student: json['student'],
      description: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'student': student,
      'description': description,
    };
  }
}
