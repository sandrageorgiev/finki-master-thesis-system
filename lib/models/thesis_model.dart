class Thesis {
  final String id;
  final String title;
  final String student;
  final String description;
  final String pdfUrl;

  Thesis(
      {required this.id,
      required this.title,
      required this.student,
      required this.description,
      String? pdfUrl})
      : pdfUrl = pdfUrl ?? '${student.replaceAll(' ', '')}.pdf';

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'],
      title: json['title'],
      student: json['student'],
      description: json['location'],
      pdfUrl: json['pdfUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'student': student,
      'description': description,
      'pdfUrl': pdfUrl,
    };
  }
}
