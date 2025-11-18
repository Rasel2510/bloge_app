import 'dart:convert';
import 'package:bloge/services/authservise/AuthService.dart';
import 'package:http/http.dart' as http;

class UpdateUser {
  final String baseurl = "https://api.zhndev.site/wp-json/blog-app/v1";

  Future<Map<String, dynamic>> useprofile(String name, String phone) async {
    final token = AuthService.getToken();

    if (token == null) {
      throw Exception('No authentication token found');
    }

    final url = Uri.parse("$baseurl/user/profile");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({"name": name, "phone": phone});

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data;
      } else {
        throw Exception('error:${response.statusCode}');
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }
}
