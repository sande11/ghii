import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repo.dart';

class ApiService {
  static Future<List<Repository>> fetchRepositories() async {
    final response = await http.get(Uri.parse('https://api.github.com/repositories'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((repo) => Repository.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
