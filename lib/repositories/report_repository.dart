import 'package:asset_guard/api/api_client.dart';
import 'package:asset_guard/models/report.dart';

class ReportRepository {
  final ApiClient apiClient;

  ReportRepository({required this.apiClient});

  Future<List<Report>> getAllReports() async {
    return await apiClient.getAllReports();
  }

  Future<Report> createReport(String title, String description) async {
    return await apiClient.createReport(title, description);
  }
  
}
