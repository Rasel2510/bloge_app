import 'package:bloge/features/auth/presentation/login_screen.dart';
import 'package:bloge/bottom_navigation_bar.dart';
import 'package:bloge/features/bookmark/presentation/bookmark_details_screen.dart';
import 'package:bloge/features/bookmark/presentation/bookmark_screen.dart';
import 'package:bloge/utils/authservise/AuthService.dart';
import 'package:bloge/features/bookmark/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(
    ChangeNotifierProvider(create: (context) => BookmarkP(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BookmarksPage(),
          // home: AuthService.isLoggedIn() ? Navigation() : Login(),
        );
      },
    );
  }
}
