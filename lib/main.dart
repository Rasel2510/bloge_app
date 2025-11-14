import 'package:bloge/features/auth/login_srceen/login.dart';
import 'package:bloge/features/navigation/navigation.dart';
import 'package:bloge/services/authservise/AuthService.dart';
import 'package:bloge/services/provider/data_provider.dart';
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

          home: AuthService.isLoggedIn() ? Navigation() : Login(),
        );
      },
    );
  }
}
