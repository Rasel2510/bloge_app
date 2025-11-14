import 'package:bloge/models/data_model.dart';
import 'package:bloge/models/get_post_model.dart';
import 'package:bloge/services/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsSrceen extends StatefulWidget {
  final Post post;
  const DetailsSrceen({super.key, required this.post});

  @override
  State<DetailsSrceen> createState() => _DetailsSrceenState();
}

class _DetailsSrceenState extends State<DetailsSrceen> {
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
                  dics: widget.post.excerpt,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.post.featuredImage != null &&
                widget.post.featuredImage!.isNotEmpty)
              ClipRRect(
                child: Image.network(
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
                ),
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
                    widget.post.content!,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
