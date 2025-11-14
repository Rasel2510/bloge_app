import 'dart:convert';

import 'package:bloge/models/get_post_model.dart';
import 'package:http/http.dart' as http;

class ApiGet {
  final String baseurl = "https://api.zhndev.site/wp-json/blog-app/v1";

  Future<PostResponse> getpost({int page = 1, int perPage = 10}) async {
    final url = Uri.parse("$baseurl/posts?page=$page&per_page=$perPage");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PostResponse.fromJson(data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
