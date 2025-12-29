import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloge/features/home/data/getapi_comment.dart';
import 'package:bloge/features/home/model/comment_model.dart';

class CommentSection extends StatefulWidget {
  final int postId;
  const CommentSection({super.key, required this.postId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _fetchComments();
  }

  Future<List<Comment>> _fetchComments() async {
    final rawData = await CommentApi().fetchCommentsByPost(widget.postId);

    if (rawData is Map &&
        rawData['data'] != null &&
        rawData['data']['comments'] != null) {
      final commentsList = rawData['data']['comments'] as List;
      return commentsList.map((json) => Comment.fromJson(json)).toList();
    }

    return [];
  }

  Future<void> _postComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    try {
      await CommentApi().addComment(widget.postId, text);
      _commentController.clear();
      setState(() {
        _commentsFuture = _fetchComments(); // Refresh comments
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to post comment: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Comment input
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Post a comment...",
                    filled: true,
                    fillColor: const Color(0xFF1F2125),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _postComment,
              ),
            ],
          ),
        ),

        // Comments list
        FutureBuilder<List<Comment>>(
          future: _commentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            final comments = snapshot.data ?? [];
            if (comments.isEmpty) {
              return const Center(
                child: Text(
                  "No comments yet",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Dismissible(
                  key: ValueKey(comment.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) async {
                    try {
                      await CommentApi().deleteComment(comment.id);
                      setState(() {
                        _commentsFuture = _fetchComments();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Comment deleted')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete comment: $e')),
                      );
                    }
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: comment.userImage.isNotEmpty
                            ? NetworkImage(comment.userImage)
                            : null,
                        child: comment.userImage.isEmpty
                            ? const Icon(Icons.person, color: Colors.white)
                            : null,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFF292E38),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                comment.comment,
                                style: TextStyle(
                                  color: const Color(0xFF9EA6BA),
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                comment.date,
                                style: TextStyle(
                                  color: const Color(0xFF6B6B6B),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
