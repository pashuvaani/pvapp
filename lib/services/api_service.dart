import '../core/network/api_client.dart';

class ApiService {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>> fetchDashboardData() async {
    final res = await _client.get('/dashboard');
    return res.data ?? {};
  }
}
