import 'package:flutter/material.dart';
import 'package:mis_project/base_app_bar.dart';
import 'package:mis_project/services/pdf_service.dart';
import 'package:mis_project/services/thesis_service.dart';
import 'package:mis_project/services/auth_service.dart';

class MyThesis extends StatelessWidget {
  const MyThesis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Мој магистерски труд',
        route: '/my_thesis',
      ),
      body: FutureBuilder(
        future: AuthService.getLoggedInUser(),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = userSnapshot.data!;
          final thesis = ThesisService.getThesisByStudentId(user.username);

          if (thesis == null) {
            return const Center(
              child: Text('Немате пријавено магистерски труд'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        children: [
                          Text(
                            thesis.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            thesis.student,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Опис',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(thesis.description),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await PdfService.downloadAndOpenPdf(thesis.pdfUrl);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error opening PDF: $e')),
                        );
                      }
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Преземи труд'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
