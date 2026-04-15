import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:asset_guard/repositories/report_repository.dart';
import 'package:asset_guard/api/api_client.dart';
import 'package:asset_guard/models/report.dart';

// Runs before the tests

// dart run build_runner build --delete-conflicting-outputs

@GenerateMocks([ApiClient])
import 'report_repository_test.mocks.dart';

void main() {
  late MockApiClient mockApiClient;
  late ReportRepository reportRepository;

  setUp(() {
    mockApiClient = MockApiClient();
    reportRepository = ReportRepository(apiClient: mockApiClient);
  });

  group('getAllReports', () {
    test('returns all reports', () async {
      // Arrange
      final mockReports = [
        Report(id: '1', title: 'Report 1', description: 'Description 1'),
        Report(id: '2', title: 'Report 2', description: 'Description 2'),
      ];

      when(mockApiClient.getAllReports()).thenAnswer((_) async => mockReports);

      // Act
      final result = await reportRepository.getAllReports();

      // Assert
      expect(result.length, 2);
      expect(result[0].title, 'Report 1');
      expect(result[1].title, 'Report 2');
    });

    test('returns empty list when no reports exist', () async {
      when(mockApiClient.getAllReports()).thenAnswer((_) async => []);
      final result = await reportRepository.getAllReports();
      expect(result.isEmpty, true);
    });

    test('throws exception when API call fails', () async {
      when(mockApiClient.getAllReports()).thenThrow(Exception('Network error'));
      expect(() => reportRepository.getAllReports(), throwsException);
    });
  });

  group('createReport', () {
    test('creates a new report', () async {
      // Arrange
      final title = 'New Report';
      final description = 'This is a new report';
      final mockReport = Report(
        id: '3',
        title: title,
        description: description,
      );

      when(
        mockApiClient.createReport(any, any),
      ).thenAnswer((_) async => mockReport);

      // Act
      final result = await reportRepository.createReport(title, description);

      // Assert
      expect(result.id, '3');
      expect(result.title, title);
      expect(result.description, description);
      verify(mockApiClient.createReport(any, any)).called(1);
    });

    test('throws exception when API call fails', () async {
      // Arrange
      final title = 'New Report';
      final description = 'This is a new report';

      when(
        mockApiClient.createReport(title, description),
      ).thenThrow(Exception('Network error'));

      // Act
      final result = reportRepository.createReport(title, description);

      // Assert
      expect(result, throwsException);
    });
  });

  group('updateReport', () {
    test('updates an existing report', () async {
      // Arrange
      final id = '1';
      final title = 'Updated Report';
      final description = 'This is an updated report';
      final mockReport = Report(id: id, title: title, description: description);

      when(
        mockApiClient.updateReport(any, any, any),
      ).thenAnswer((_) async => mockReport);

      // Act
      final result = await reportRepository.updateReport(
        id,
        title,
        description,
      );

      // Assert
      expect(result.id, id);
      expect(result.title, title);
      expect(result.description, description);
      verify(mockApiClient.updateReport(any, any, any)).called(1);
    });

    test('throws exception when API call fails', () async {
      // Arrange
      final id = '1';
      final title = 'Updated Report';
      final description = 'This is an updated report';

      when(
        mockApiClient.updateReport(id, title, description),
      ).thenThrow(Exception('Network error'));

      // Act
      final result = reportRepository.updateReport(id, title, description);

      // Assert
      expect(result, throwsException);
    });
  });

  group('deleteReport', () {
    test('deletes an existing report', () async {
      // Arrange
      final id = '1';

      when(
        mockApiClient.deleteReport(id),
      ).thenAnswer((_) async => Future.value());

      // Act
      await reportRepository.deleteReport(id);

      // Assert
      verify(mockApiClient.deleteReport(id)).called(1);
    });

    test('throws exception when API call fails', () async {
      // Arrange
      final id = '1';

      when(
        mockApiClient.deleteReport(id),
      ).thenThrow(Exception('Network error'));

      // Act
      final result = reportRepository.deleteReport(id);

      // Assert
      expect(result, throwsException);
    });
  });
}
