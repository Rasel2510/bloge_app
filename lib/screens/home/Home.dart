import 'package:bloge/models/get_post_model.dart';
import 'package:bloge/screens/home/details_srceen.dart';
import 'package:bloge/services/Api_service/api_get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<PostResponse> postsFuture;
  final api = ApiGet();

  @override
  void initState() {
    super.initState();
    postsFuture = api.getpost(page: 1, perPage: 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        title: Text('Blog Posts', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF121217),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: FutureBuilder<PostResponse>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading posts${snapshot.error}",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.posts.isEmpty) {
              return Center(
                child: Text(
                  "No posts found",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              );
            }

            final posts = snapshot.data!.posts;

            return ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsSrceen(post: post),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    elevation: 3,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category text
                                Text(
                                  post.categories[0],
                                  style: TextStyle(
                                    color: Color(0xFF9EA6BA),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  post.title,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  post.excerpt,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xFF9EA6BA),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                              ],
                            ),
                          ),
                          // Image
                          if (post.featuredImage != null &&
                              post.featuredImage!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                post.featuredImage!,
                                width: 130.w,
                                height: 130.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 130.w,
                                    height: 130.h,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.image, size: 30.w),
                                  );
                                },
                              ),
                            )
                          else
                            Container(
                              width: 130.w,
                              height: 130.h,
                              color: Colors.grey[300],
                              child: Icon(Icons.article, size: 30.w),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
