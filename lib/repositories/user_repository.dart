import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';

class UserRepository {
  static const String _baseUrl = 'https://reqres.in/api';

  // Api key dari .env
  String get _apiKey => dotenv.env['API_KEY'] ?? '';

  Future<List<UserModel>> fetchUsers({int page = 1, int perPage = 6}) async {
    final uri = Uri.parse('$_baseUrl/users?page=$page&per_page=$perPage');

    try {
      final res = await http.get(uri, headers: {'x-api-key': _apiKey});

      if (res.statusCode != 200) {
        throw Exception('Failed to load users. Status code: ${res.statusCode}');
      }

      final Map<String, dynamic> json = jsonDecode(res.body);
      final List userList = json['data'] ?? [];

      return userList.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
