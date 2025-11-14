import 'package:bloge/services/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookmarkP>(context, listen: false).loadData();
    });

    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bookmarks', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF121217),
      ),
      body: Consumer<BookmarkP>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.bookmark.isEmpty) {
            return Center(
              child: Text(
                "NO BOOKMARK YET",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: provider.bookmark.length,
            itemBuilder: (context, index) {
              final item = provider.bookmark[index];
              return Card(
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
                      // Image
                      if (item.image.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            item.image,
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

                      SizedBox(width: 12.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
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
                              item.dics,
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
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
