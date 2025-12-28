import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookmarkDetailsScreen extends StatelessWidget {
  final dynamic item;
  const BookmarkDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF121217),
      //   title: Text("Bookmarks", style: const TextStyle(color: Colors.white)),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Bookmarks",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
            SizedBox(height: 16.h),

            /// Image
            item.image != null && item.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      item.image,
                      width: double.infinity,
                      height: 220.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _imageFallback();
                      },
                    ),
                  )
                : _imageFallback(),

            SizedBox(height: 16.h),

            /// Title
            Text(
              item.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 12.h),

            /// Description
            Text(
              item.dics,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9EA6BA)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        height: 220.h,
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
