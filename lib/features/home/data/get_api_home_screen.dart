import 'dart:convert';

import 'package:bloge/features/home/model/get_api_home_screen_model.dart';
import 'package:http/http.dart' as http;

class GetApiHomeScreen {
  final String baseurl = "https://api.zhndev.site/wp-json/blog-app/v1";

  Future<PostResponse> getpost({int page = 1, int perPage = 50}) async {
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
