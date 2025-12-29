import 'package:bloge/features/bookmark/model/save_bookmark_model.dart';
import 'package:bloge/features/home/data/getapi_comment.dart';
import 'package:bloge/features/home/model/get_api_home_screen_model.dart';
import 'package:bloge/features/bookmark/data/data_provider.dart';
import 'package:bloge/features/home/model/comment_model.dart';
import 'package:bloge/widgets/textformfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final Post post;
  const DetailsScreen({super.key, required this.post});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _fetchComments();
  }

  Future<List<Comment>> _fetchComments() async {
    try {
      final rawData = await CommentApi().fetchCommentsByPost(widget.post.id);
      print("Raw comments: $rawData");

      if (rawData is List) {
        return rawData.map((json) => Comment.fromJson(json)).toList();
      } else if (rawData is Map && rawData['comments'] != null) {
        final comments = rawData['comments'] as List;
        return comments.map((json) => Comment.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching comments: $e");
    }
    return [];
  }

  Future<void> _postComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    try {
      await CommentApi().addComment(widget.post.id, commentText);
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
    final pbookmark = Provider.of<BookmarkP>(context);
    bool isBookmarked = pbookmark.isBookmarked(widget.post.id);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                DataModel data = DataModel(
                  id: widget.post.id,
                  image: widget.post.featuredImage ?? '',
                  title: widget.post.title,
                  dics: widget.post.content ?? '',
                );
                await pbookmark.togglebookmark(data);
              },
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
                color: isBookmarked ? Colors.blue : Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post image
            if (widget.post.featuredImage != null &&
                widget.post.featuredImage!.isNotEmpty)
              Image.network(
                widget.post.featuredImage!,
                width: double.infinity,
                height: 320.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 320.h,
                    width: double.infinity,
                    color: Colors.grey,
                    child: Icon(Icons.image, size: 100.w),
                  );
                },
              )
            else
              Container(
                width: double.infinity,
                height: 320.h,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 100.w),
              ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundImage: widget.post.author.avatar.isNotEmpty
                            ? NetworkImage(widget.post.author.avatar)
                            : null,
                        child: widget.post.author.avatar.isEmpty
                            ? Icon(Icons.person, size: 12.r)
                            : null,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Author",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.post.author.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.post.content ?? "",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.post.likeCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(width: 30.w),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.comment_bank_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.post.commentCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  FutureBuilder<List<Comment>>(
                    future: _commentsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      final comments = snapshot.data ?? [];
                      if (comments.isEmpty) {
                        return const Text(
                          "No comments yet",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20.r,
                                backgroundImage: comment.userImage.isNotEmpty
                                    ? NetworkImage(comment.userImage)
                                    : null,
                                backgroundColor: Colors.grey,
                                child: comment.userImage.isEmpty
                                    ? const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      )
                                    : null,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextForm(
          borderRadius: 30,
          hintText: "Post a comment...",
          controller: _commentController,
          suffixIcon: IconButton(
            onPressed: _postComment,
            icon: const Icon(Icons.send, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
