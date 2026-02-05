import 'package:flutter/material.dart';
import 'app_tour_step.dart';

class AppTourController extends ChangeNotifier {
  final List<AppTourStep> steps;
  int _currentIndex = 0;

  AppTourController(this.steps);

  int get currentIndex => _currentIndex;
  AppTourStep get currentStep => steps[_currentIndex];
  bool get isLast => _currentIndex == steps.length - 1;

  void next() {
    if (!isLast) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void skip() {
    _currentIndex = steps.length;
    notifyListeners();
  }
}
