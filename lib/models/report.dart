import 'package:uuid/uuid.dart';

class Report {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  Report({
    String? id,
    required this.title,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isDeleted = false,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Report copyWith({
    String? title,
    String? description,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return Report(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  // Map for firestore serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }

  // Factory constructor for creating a Report from a map
  factory Report.fromMap(Map<String, dynamic> map) {
    // Parse dates - handle both string and timestamp formats
    DateTime parseDate(dynamic dateValue) {
      if (dateValue == null) {
        return DateTime.now();
      }
      if (dateValue is String) {
        try {
          return DateTime.parse(dateValue);
        } catch (e) {
          return DateTime.now();
        }
      }
      if (dateValue is DateTime) {
        return dateValue;
      }
      return DateTime.now();
    }

    return Report(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      createdAt: parseDate(map['createdAt']),
      updatedAt: parseDate(map['updatedAt']),
      isDeleted: map['isDeleted'] as bool? ?? false,
    );
  }
}
