import 'package:mis_project/models/thesis_model.dart';

class ThesisService {
  static List<Thesis> getThesis() {
    return [
      Thesis(
        id: '1',
        title: 'Mobile Information Systems',
        student: 'Sandra Georgiev',
        description: 'test test test test test',
      ),
      Thesis(
        id: '2',
        title: 'Web Programming',
        student: 'Andrej Vlahovski',
        description: 'test test test test test',
      ),
      Thesis(
        id: '3',
        title: 'Artificial Intelligence',
        student: 'Jovana Cocevska',
        description: 'test test test test test',
      ),
    ];
  }
}
