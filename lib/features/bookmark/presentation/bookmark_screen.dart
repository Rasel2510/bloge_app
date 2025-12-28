import 'package:bloge/features/bookmark/data/data_provider.dart';
import 'package:bloge/features/bookmark/presentation/bookmark_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
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
        backgroundColor: Colors.transparent,
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
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.all(12.w),
            itemCount: provider.bookmark.length,
            itemBuilder: (context, index) {
              final item = provider.bookmark[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookmarkDetailsScreen(item: item),
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
                        // Image
                        item.image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.network(
                                  item.image,
                                  width: 130.w,
                                  height: 130.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _imageFallback();
                                  },
                                ),
                              )
                            : _imageFallback(),

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
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _imageFallback() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 130.w,
        height: 130.h,
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.black54,
          size: 40,
        ),
      ),
    );
  }
}
