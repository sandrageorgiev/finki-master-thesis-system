import 'package:flutter/material.dart';
import 'package:mis_project/services/thesis_service.dart';

class ThesisList extends StatefulWidget {
  const ThesisList({super.key});

  @override
  State<ThesisList> createState() => _ThesisListState();
}

class _ThesisListState extends State<ThesisList> {
  bool isExpanded = false;
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final theses = ThesisService.getThesis();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        title: const Text(
          'Листа на магистерски трудови',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: 'Search',
              trailing: [Icon(Icons.mic), Text('Cancel')],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: theses.length,
              itemBuilder: (context, index) {
                final thesis = theses[index];
                return ExpansionTile(
                  leading: const Icon(Icons.book),
                  title: Text(thesis.title),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.school, size: 16),
                      const SizedBox(width: 4),
                      Text(thesis.student),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(thesis.description),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:mis_project/services/thesis_service.dart';

// class ThesisList extends StatelessWidget {
//   const ThesisList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theses = ThesisService.getThesis();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
//         ),
//         title: const Text(
//           'Листа на магистерски трудови',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: SearchBar(
//               hintText: 'Search',
//               trailing: [Icon(Icons.mic), Text('Cancel')],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: theses.length,
//               itemBuilder: (context, index) {
//                 final thesis = theses[index];
//                 return Card(
//                   child: ListTile(
//                     leading: const Icon(Icons.book),
//                     title: Text(thesis.title),
//                     subtitle: Row(
//                       children: [
//                         const Icon(Icons.school, size: 16),
//                         const SizedBox(width: 4),
//                         Text(thesis.student),
//                       ],
//                     ),
//                     onTap: () => showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text(thesis.title),
//                         content: Text(thesis.description),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('Close'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
