import 'dart:convert';
import 'package:bloge/features/profile/model/get_api_user_details_model.dart';
import 'package:bloge/utils/authservise/AuthService.dart';
import 'package:http/http.dart' as http;

class GetAPIuserProfile {
  final String baseurl = "https://api.zhndev.site/wp-json/blog-app/v1";

  Future<UserProfileResponse> getuserprofile() async {
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

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserProfileResponse.fromJson(data);
      } else {
        throw Exception('error:${response.statusCode}');
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }
}
