import 'package:flutter/material.dart';

class AppTourStep {
  final GlobalKey targetKey;
  final String title;
  final String description;

  AppTourStep({
    required this.targetKey,
    required this.title,
    required this.description,
  });
}
