import 'dart:convert';

import 'package:trilhaapp/model/comment_model.dart';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/repositories/comments/comments_repository.dart';

class CommentsHttpRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    final response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/$postId/comments"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json as List).map((e) => CommentModel.fromJson(e)).toList();
    }

    return [];
  }
}
