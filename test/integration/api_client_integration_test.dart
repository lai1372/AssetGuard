import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:asset_guard/api/api_client.dart';

void main() {
  group('ApiClient Integration Tests - getAllReports', () {
    late FakeFirebaseFirestore fakeFirestore;
    late ApiClient apiClient;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      apiClient = ApiClient(fakeFirestore);
    });

    test('returns all non-deleted reports', () async {
      // Arrange - Add test data to fake firestore
      await fakeFirestore.collection('reports').doc('1').set({
        'id': '1',
        'title': 'Report 1',
        'description': 'Description 1',
        'isDeleted': false,
        'createdAt': '2024-01-01T10:00:00.000Z',
        'updatedAt': '2024-01-01T10:00:00.000Z',
      });

      await fakeFirestore.collection('reports').doc('2').set({
        'id': '2',
        'title': 'Report 2',
        'description': 'Description 2',
        'isDeleted': false,
        'createdAt': '2024-01-02T10:00:00.000Z',
        'updatedAt': '2024-01-02T10:00:00.000Z',
      });

      // Act
      final result = await apiClient.getAllReports();

      // Assert
      expect(result.length, 2);
      expect(result[0].title, 'Report 1');
      expect(result[1].title, 'Report 2');
    });

    test('filters out deleted reports', () async {
      // Arrange
      await fakeFirestore.collection('reports').doc('1').set({
        'id': '1',
        'title': 'Report 1',
        'description': 'Description 1',
        'isDeleted': false,
        'createdAt': '2024-01-01T10:00:00.000Z',
        'updatedAt': '2024-01-01T10:00:00.000Z',
      });

      await fakeFirestore.collection('reports').doc('2').set({
        'id': '2',
        'title': 'Deleted Report',
        'description': 'Description 2',
        'isDeleted': true,
        'createdAt': '2024-01-02T10:00:00.000Z',
        'updatedAt': '2024-01-02T10:00:00.000Z',
      });

      // Act
      final result = await apiClient.getAllReports();

      // Assert
      expect(result.length, 1);
      expect(result[0].title, 'Report 1');
    });

    test('returns empty list when no reports exist', () async {
      // Act
      final result = await apiClient.getAllReports();

      // Assert
      expect(result.isEmpty, true);
    });
  });

  group('ApiClient Integration Tests - createReport', () {
    late FakeFirebaseFirestore fakeFirestore;
    late ApiClient apiClient;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      apiClient = ApiClient(fakeFirestore);
    });

    test('creates a new report and logs audit', () async {
      // Act
      final newReport = await apiClient.createReport('New Report', 'New Description');

      // Assert
      final docSnapshot = await fakeFirestore.collection('reports').doc(newReport.id).get();
      expect(docSnapshot.exists, true);
      expect(docSnapshot.data()!['title'], 'New Report');
      expect(docSnapshot.data()!['description'], 'New Description');
      expect(docSnapshot.data()!['isDeleted'], false);

      // Assert
      final auditLogsSnapshot = await fakeFirestore.collection('audit_logs').where('reportId', isEqualTo: newReport.id).get();
      expect(auditLogsSnapshot.docs.length, 1);
      expect(auditLogsSnapshot.docs.first.data()['action'], 'create');
    });
  });

  group('ApiClient Integration Tests - updateReport', () {
    late FakeFirebaseFirestore fakeFirestore;
    late ApiClient apiClient;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      apiClient = ApiClient(fakeFirestore);
    });

    test('updates an existing report and logs audit', () async {
      // Arrange
      await fakeFirestore.collection('reports').doc('1').set({
        'id': '1',
        'title': 'Report 1',
        'description': 'Description 1',
        'isDeleted': false,
        'createdAt': '2024-01-01T10:00:00.000Z',
        'updatedAt': '2024-01-01T10:00:00.000Z',
      });

      // Act
      final updatedReport = await apiClient.updateReport('1', 'Report 1 (Updated)', 'Description 1 (Updated)');

      // Assert
      final docSnapshot = await fakeFirestore.collection('reports').doc('1').get();
      expect(docSnapshot.exists, true);
      expect(docSnapshot.data()!['title'], 'Report 1 (Updated)');
      expect(docSnapshot.data()!['description'], 'Description 1 (Updated)');

      // Assert
      final auditLogsSnapshot = await fakeFirestore.collection('audit_logs').where('reportId', isEqualTo: '1').get();
      expect(auditLogsSnapshot.docs.length, 1);
      expect(auditLogsSnapshot.docs.first.data()['action'], 'update');
    });

    test('throws exception when report does not exist', () async {

      // Arrange 
      final docSnapshot = await fakeFirestore.collection('reports').doc('nonexistent').get();

      expect(docSnapshot.exists, false);

      // Act & Assert
      expect(() => apiClient.updateReport('nonexistent', 'Title', 'Description'), throwsException);

    });
  });
}
