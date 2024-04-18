import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

class PostsHttpRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }
}
