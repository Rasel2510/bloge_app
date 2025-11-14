import 'package:bloge/features/navigation/navigation.dart';
import 'package:bloge/services/Api_service/api_singup.dart';
import 'package:bloge/widgets/elevated_button.dart';
import 'package:bloge/widgets/textformfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final TextEditingController singusername = TextEditingController();
  final TextEditingController singemail = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController singpassword = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final api = ApiSingup();

  bool isLoading = false;

  void hsingup() async {
    final name = singusername.text.trim();
    final email = singemail.text.trim();
    final phon = phone.text.trim();
    final password = singpassword.text.trim();
    final cpass = cpassword.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phon.isEmpty ||
        password.isEmpty ||
        cpass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All fields are required"),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    if (password != cpass) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    try {
      setState(() => isLoading = true);
      final result = await api.singin(name, email, password, phon);
      setState(() => isLoading = false);

      print("Signup successful: $result");

      if (result != null && result['success'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Navigation()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Signup failed")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121217),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 8.h),
                TextForm(
                  hintText: "Enter your username",
                  controller: singusername,
                ),

                SizedBox(height: 30.h),
                Text(
                  'Email',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 8.h),
                TextForm(hintText: "Enter your Email", controller: singemail),

                SizedBox(height: 30.h),
                Text(
                  'Phone',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 8.h),
                TextForm(hintText: "Enter your Phone", controller: phone),

                SizedBox(height: 30.h),
                Text(
                  'Password',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 8.h),
                TextForm(
                  hintText: "Enter your password",
                  controller: singpassword,
                ),

                SizedBox(height: 30.h),
                Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 8.h),
                TextForm(
                  hintText: "Confirm your password",
                  controller: cpassword,
                ),

                SizedBox(height: 30.h),
                CustomElevatedButton(
                  onPressed: isLoading ? () {} : hsingup,
                  text: isLoading ? "" : "Register",
                  borderRadius: 12.r,
                  bcolor: Color(0xFFE36527),
                  fcolor: Colors.white,
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
