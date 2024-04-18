import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/repositories/comments/comments_repository.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custom_dio.dart';

class CommentsDioRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    final jsonPlaceHolderCustomDio = JsonPlaceHolderCustomDio();
    final response =
        await jsonPlaceHolderCustomDio.dio.get("/posts/$postId/comments");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }

    return [];
  }
}
