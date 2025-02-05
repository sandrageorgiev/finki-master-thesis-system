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
            child: SingleChildScrollView(
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
                            const SizedBox(height: 8),
                            Text(
                              '(${thesis.studentId})',
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
                  const SizedBox(height: 32),
                  _buildIdTile('ИД', thesis.id),
                  _buildDateTile(thesis.date),
                  _buildStatusTile('Статус', thesis.status),
                  _buildConsentTile('Согласност од студентот', 'Да'),
                  _buildThesisInfoTile(
                      'Пријавена со кредити (180/240)', thesis.credits),
                  const SizedBox(height: 64),
                  _buildDocumentTile('Документација'),
                  const SizedBox(height: 16),
                  _buildEmptyTile("Преглед"),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          await PdfService.downloadAndOpenPdf(thesis.pdfUrl);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Немате прикачено труд !')),
                          );
                        }
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Преземи труд'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildThesisInfoTile(String title, String value) {
  return Card(
    color: Colors.blueGrey[50],
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(value, style: const TextStyle(fontSize: 18)),
    ),
  );
}

Widget _buildStatusTile(String title, String value) {
  return Card(
    color: Colors.blueGrey[50],
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 18)),
        trailing:
            const Icon(Icons.priority_high, color: Colors.blue, size: 28)),
  );
}

Widget _buildConsentTile(String title, String value) {
  return Card(
      color: Colors.blueGrey[50],
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 18)),
        trailing: Icon(
          value == 'Да' ? Icons.check : Icons.cancel,
          color: value == 'Да' ? Colors.green : Colors.red,
          size: 24,
        ),
      ));
}

Widget _buildIdTile(String title, String value) {
  return Card(
    color: Colors.blueGrey[50],
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.numbers, color: Colors.blue, size: 28)),
  );
}

Widget _buildDateTile(String date) {
  return Card(
    color: Colors.blueGrey[50],
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      //leading: const Icon(Icons.calendar_today, color: Colors.blue, size: 28),
      title: const Text(
        'Датум',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        date,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: const Icon(Icons.calendar_today, color: Colors.blue, size: 28),
    ),
  );
}

Widget _buildDocumentTile(String title) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () async {},
      icon: const Icon(Icons.cloud_download_rounded),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
      ),
    ),
  );
}

Widget _buildEmptyTile(String title) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () async {},
      icon: const Icon(Icons.file_copy_sharp),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 220, 220, 220),
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.all(16),
      ),
    ),
  );
}
