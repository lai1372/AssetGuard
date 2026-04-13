import 'package:uuid/uuid.dart';

class Attachment {
  final String id;
  final String reportId;
  final String filePath;
  final String fileName;
  final String syncStatus;
  final DateTime createdAt;

  Attachment({
    String? id,
    required this.reportId,
    required this.filePath,
    required this.fileName,
    DateTime? createdAt,
    this.syncStatus = 'pending',
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Attachment{id: $id, reportId: $reportId, filePath: $filePath, fileName: $fileName, createdAt: $createdAt, syncStatus: $syncStatus}';
  }
}