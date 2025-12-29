import 'dart:convert';
import 'package:bloge/utils/authservise/AuthService.dart';
import 'package:http/http.dart' as http;

class CommentApi {
  final String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1";

  Map<String, String> getHeaders() {
    final token = AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future fetchCommentsByPost(int postId) async {
    final url = Uri.parse("$baseUrl/comments/post/$postId");
    final response = await http.get(url, headers: getHeaders());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load comments: ${response.statusCode}");
    }
  }

  Future addComment(int postId, String comment) async {
    final url = Uri.parse("$baseUrl/comments");
    final body = jsonEncode({"post_id": postId, "comment": comment});
    final response = await http.post(url, headers: getHeaders(), body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to add comment: ${response.statusCode} ${response.body}",
      );
    }
  }

  Future deleteComment(int commentId) async {
    final url = Uri.parse("$baseUrl/comments/$commentId");
    final response = await http.delete(url, headers: getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to delete comment: ${response.statusCode}");
    }
  }
}
