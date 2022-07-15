import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise.dart';


class ExercisesProvider with ChangeNotifier {
  final List<Exercise> _items = [
    Exercise(
      id: 'w1',
      title: 'SQUAT',
      imageUrl: 'images/Squat_man.jpg',
      bottom: 100,
      left: 230
    ),
    Exercise(
      id: 'w2',
      title: 'PUSH UP',
      imageUrl: 'images/pushup__.jpg',
      bottom: 25,
      left: 50
    ),
    Exercise(
      id: 'w3',
      title: 'SPLIT',
      imageUrl: 'images/split__.jpg',
      bottom: 100,
      left: 50
    ),
    Exercise(
      id: 'w4',
      title: 'LUNGES',
      imageUrl: 'images/lunges.jpg',
      bottom: 100,
      left: 230
    ),
    // Exercise(
    //   id: 'w5',
    //   title: 'LEG DEADLIFT',
    //   imageUrl: 'images/legdeadlift.jpg',
    // ),
  ];

  List<Exercise> get items {
    return [..._items];
  }

  Exercise findItemById(String exerciseId) {
    return _items.firstWhere((item) => item.id == exerciseId);
  }

  
}
