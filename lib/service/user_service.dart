import 'package:http/http.dart' as http;

class UserService {
  Future<bool> changeSubcriptionStatus(int userId) async {
    final apiUrl =
        'https://foodiapi.azurewebsites.net/api/User/ChangeSubcriptionStatus/$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load trending restaurants');
    }
  }
}
