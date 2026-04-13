import 'package:uuid/uuid.dart';

class Report {
  final String id;
  final String title;
  final String description;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  Report({
    String? id,
    required this.title,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.syncStatus = 'pending',
    this.isDeleted = false,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  @override
  String toString() {
    return 'Report{id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted}';
  }
}
