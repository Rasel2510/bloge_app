import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiSingup {
  final String baseurl = "https://api.zhndev.site/wp-json/blog-app/v1";

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future singin(
    String singusername,
    String singemail,
    String singpassword,
    String phone,
  ) async {
    final url = Uri.parse("$baseurl/auth/register");
    final body = jsonEncode({
      "name": singusername,
      "email": singemail,
      "password": singpassword,
      "phone": phone,
    });
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
