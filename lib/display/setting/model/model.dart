import 'package:flutter/material.dart';

class ProjectListItemInfo {
  ProjectListItemInfo({
    required this.projectId,
    required this.projectName,
    required this.themeColor,
  });

  final String projectId;
  final String projectName;
  final Color themeColor;
}
