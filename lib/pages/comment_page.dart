import 'package:flutter/material.dart';
import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/repositories/comments/comments_repository.dart';
import 'package:trilhaapp/repositories/comments/impl/comments_dio_repository.dart';

class CommentPage extends StatefulWidget {
  final int postId;

  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late CommentsRepository _commentsRepository;

  var comments = <CommentModel>[];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _commentsRepository = CommentsDioRepository();
    carregarDados();
  }

  void carregarDados() async {
    setState(() {
      loading = true;
    });
    comments = await _commentsRepository.retornaComentarios(widget.postId);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Comentários do Post: ${widget.postId}"),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (_, index) {
                    var comment = comments[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(comment.name.substring(0, 6)),
                                Text(comment.email),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(comment.body),
                          ],
                        ),
                      ),
                    );
                  },
                )),
    ));
  }
}
