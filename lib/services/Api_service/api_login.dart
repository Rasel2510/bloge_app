import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiLogin {
  final String baseurl = "https://api.zhndev.site/wp-json/blog-app/v1";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future login(String email, String password) async {
    final url = Uri.parse("$baseurl/auth/login");

    final body = jsonEncode({"email": email, "password": password});
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('error:${response.statusCode}');
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }
}
