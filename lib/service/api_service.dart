import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService({
    required this.client,
  });

  Future<String> fetchData() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['title'] ?? "No title available";
    }
    if (response.statusCode == 404) {
      return "Something went wrong";
    } else {
      throw Exception('Failed to load data');
    }
  }
}