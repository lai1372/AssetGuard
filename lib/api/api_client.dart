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
    final snapshot = await _reports
        .where('isDeleted', isEqualTo: false)
        .get();
    debugPrint(
      '[API] GET /reports - fetched ${snapshot.docs.length} reports${snapshot.metadata.isFromCache ? ' (from local storage)' : ''}',
    );
    return snapshot.docs.map((doc) => Report.fromMap(doc.data())).toList();
  }

  Future<Report> createReport(String title, String description) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  Future<Report> updateReport(
    String id,
    String title,
    String description,
  ) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  Future<void> deleteReport(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
