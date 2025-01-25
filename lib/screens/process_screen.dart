import 'package:flutter/material.dart';
import 'package:mis_project/services/process_step_service.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final steps = ProcessStepService.getSteps();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        title: const Text(
          'Постапка за пријавување',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];
          return ExpansionTile(
            title: Text('${step.id}. ${step.title}'),
            backgroundColor: Colors.grey[200],
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Валидира: ${step.validator}'),
                    const SizedBox(height: 8),
                    Text(step.description),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
