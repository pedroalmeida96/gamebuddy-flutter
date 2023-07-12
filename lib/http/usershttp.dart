import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/appuser.dart';

const String baseUrl = 'http://10.0.2.2:8080/api/users';

Future<List<AppUser>> fetchUsers() async {
  final response = await http.get(Uri.parse(baseUrl));
  if (response.statusCode == 200) {
    final List<dynamic> appUsersJson = jsonDecode(response.body);
    return appUsersJson.map((json) => AppUser.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch users');
  }
}
