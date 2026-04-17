import 'package:asset_guard/models/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final FirebaseFirestore _firestore;

  ApiClient([FirebaseFirestore? firestore])
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _reports =>
      _firestore.collection('reports');
  CollectionReference<Map<String, dynamic>> get _audit_logs =>
      _firestore.collection('audit_logs');

  Future<List<Report>> getAllReports() async {
    debugPrint('[API] GET /reports - fetching all reports');
    final snapshot = await _reports.where('isDeleted', isEqualTo: false).get();
    debugPrint(
      '[API] GET /reports - fetched ${snapshot.docs.length} reports${snapshot.metadata.isFromCache ? ' (from local storage)' : ''}',
    );
    return snapshot.docs.map((doc) => Report.fromMap(doc.data())).toList();
  }

  Future<Report> createReport(String title, String description) async {
    debugPrint('[API] POST /reports - creating report with title: "$title"');
    final newReport = Report(title: title, description: description);
    await _reports.doc(newReport.id).set(newReport.toMap());
    debugPrint('[API] POST /reports - created report with ID: ${newReport.id}');
    await _audit_logs.add({
      'action': 'create',
      'reportId': newReport.id,
      'timestamp': DateTime.now().toIso8601String(),
    });
    debugPrint(
      '[API] POST /reports - logged audit for report ID: ${newReport.id}',
    );
    return newReport;
  }

  Future<Report> updateReport(String id, String title, String description) async {
    debugPrint('[API] PUT /reports/$id - updating report with title: "$title"');
    final docRef = _reports.doc(id);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      debugPrint('[API] PUT /reports/$id - report not found');
      throw Exception('Report not found');
    }

    final updatedReport = Report(
      id: id,
      title: title,
      description: description,
      createdAt: DateTime.parse(docSnapshot.data()!['createdAt']),
      updatedAt: DateTime.now(),
      isDeleted: docSnapshot.data()!['isDeleted'] ?? false,
    );

    await docRef.set(updatedReport.toMap());
    debugPrint('[API] PUT /reports/$id - updated report with ID: $id');

    await _audit_logs.add({
      'action': 'update',
      'reportId': id,
      'timestamp': DateTime.now().toIso8601String(),
    });
    debugPrint(
      '[API] PUT /reports/$id - logged audit for report ID: $id',
    );

    return updatedReport;
  }

  Future<void> deleteReport(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
