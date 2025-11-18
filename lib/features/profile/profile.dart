import 'package:bloge/features/auth/login_srceen/login.dart';
import 'package:bloge/features/profile/edit_profile.dart';
import 'package:bloge/models/user_model.dart';
import 'package:bloge/services/Api_service/get_user.dart';
import 'package:bloge/services/authservise/AuthService.dart';
import 'package:bloge/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void _logout(BuildContext context) {
    AuthService.logout();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Loged out successfully"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF121217),
        title: Text("Profile"),
      ),
      backgroundColor: Color(0xFF121217),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<UserProfileResponse>(
            future: ApiProfile().getuserprofile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'error:${snapshot.error}',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                );
              }
              if (!snapshot.hasData || !snapshot.data!.success) {
                return Center(
                  child: Text(
                    "no profile found",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                );
              }
              final user = snapshot.data!.user;
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Color(0xFFE36527),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      user.name,
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF9EA6BA),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Software Engineer",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF9EA6BA),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF292E38),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    name: user.name,
                                    phone: user.phone,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF292E38),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.lock_outline, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Update Password",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 240.h),
                    CustomElevatedButton(
                      text: "Log out",
                      fcolor: Colors.white,
                      onPressed: () {
                        _logout(context);
                      },
                      bcolor: Color(0xFF292E38),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
