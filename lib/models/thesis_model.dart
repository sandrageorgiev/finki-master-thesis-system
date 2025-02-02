class Thesis {
  final String id;
  final String title;
  final String studentId;
  final String student;
  final String description;
  final String pdfUrl;

  Thesis(
      {required this.id,
      required this.title,
      required this.studentId,
      required this.student,
      required this.description,
      String? pdfUrl})
      // : pdfUrl = pdfUrl ?? '${student.replaceAll(' ', '')}.pdf';
      : pdfUrl = pdfUrl ?? '$studentId.pdf';

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'],
      title: json['title'],
      studentId: json['studentId'],
      student: json['student'],
      description: json['location'],
      pdfUrl: json['pdfUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'studentId': studentId,
      'student': student,
      'description': description,
      'pdfUrl': pdfUrl,
    };
  }
}
