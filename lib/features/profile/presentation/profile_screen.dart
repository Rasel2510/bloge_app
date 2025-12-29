import 'package:bloge/features/auth/presentation/login_screen.dart';
import 'package:bloge/features/profile/presentation/edit_profile_screen.dart';
import 'package:bloge/features/profile/model/get_api_user_details_model.dart';
import 'package:bloge/features/profile/data/get_api_user_profile.dart';
import 'package:bloge/utils/authservise/AuthService.dart';
import 'package:bloge/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserProfileResponse> _profileFuture;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    _profileFuture = GetAPIuserProfile().getuserprofile();
  }

  void _logout(BuildContext context) {
    AuthService.logout();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Loged out successfully"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF121217),
        title: const Text("Profile"),
      ),
      backgroundColor: const Color(0xFF121217),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<UserProfileResponse>(
            future: _profileFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                      backgroundColor: const Color(0xFFE36527),
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
                        color: const Color(0xFF9EA6BA),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Software Engineer",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF9EA6BA),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    InkWell(
                      onTap: () async {
                        final refreshed = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfile(name: user.name, phone: user.phone),
                          ),
                        );

                        if (refreshed == true) {
                          setState(() {
                            _loadProfile();
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF292E38),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, color: Colors.white),
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
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF292E38),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
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
                      onPressed: () => _logout(context),
                      bcolor: const Color(0xFF292E38),
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
