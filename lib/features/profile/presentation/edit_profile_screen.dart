import 'package:bloge/features/profile/data/post_api_update_profile.dart';
import 'package:bloge/widgets/elevated_button.dart';
import 'package:bloge/widgets/textformfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String phone;

  const EditProfile({super.key, required this.name, required this.phone});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text = widget.name;
    _phone.text = widget.phone;
  }

  Future<void> updatep() async {
    final newname = _name.text.trim();
    final newphone = _phone.text.trim();

    if (newname.isEmpty || newphone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter Your Name and Phone")),
      );
      return;
    }

    try {
      final result = await PostApiUpdateProfile().useprofile(newname, newphone);

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Update successfully"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context, true); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? "update failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF121217),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 70.r,
                    backgroundColor: const Color(0xFFE36527),
                    child: Icon(Icons.person, color: Colors.white, size: 40.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 22.sp, color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.phone,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFF9EA6BA),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Display Name',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5.h),
                    TextForm(controller: _name, hintText: "Enter your name"),
                    SizedBox(height: 16.h),
                    Text(
                      'Phone',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5.h),
                    TextForm(controller: _phone, hintText: "Enter your phone"),
                    Text(
                      'bio',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                    SizedBox(height: 5.h),
                    const TextForm(maxline: 3),
                  ],
                ),
                SizedBox(height: 110.h),
                CustomElevatedButton(
                  text: 'Save Changes',
                  onPressed: updatep,
                  fcolor: Colors.white,
                  bcolor: const Color(0xFFE36527),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
