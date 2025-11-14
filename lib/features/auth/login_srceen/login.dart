import 'package:bloge/features/auth/login_srceen/singup.dart';
import 'package:bloge/features/navigation/navigation.dart';
import 'package:bloge/services/Api_service/api_login.dart';
import 'package:bloge/services/authservise/AuthService.dart';
import 'package:bloge/widgets/elevated_button.dart';
import 'package:bloge/widgets/textformfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final api = ApiLogin();
  bool isLoading = false;

  void handleLogin() async {
    final userEmail = email.text.trim();
    final userPassword = password.text.trim();

    if (userEmail.isEmpty || userPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await api.login(userEmail, userPassword);

      print("Login successful: $result");

      if (result['success'] == true) {
        final token = result['data']['token'];
        AuthService.saveToken(token);

        //navigation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Login failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121217),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Sign in"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                ),
                SizedBox(height: 10.h),
                TextForm(hintText: "Email", controller: email),
                SizedBox(height: 12.h),
                TextForm(hintText: "Password", controller: password),
                SizedBox(height: 50.h),
                isLoading
                    ? const CircularProgressIndicator(color: Color(0xFFE36527))
                    : CustomElevatedButton(
                        onPressed: handleLogin,
                        text: "Log in",
                        borderRadius: 12.r,
                        bcolor: const Color(0xFFE36527),
                        fcolor: Colors.white,
                      ),
                SizedBox(height: 340.h),
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 14.sp, color: Color(0xFF9EA6BA)),
                ),
                SizedBox(height: 19.h),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Singup()),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(fontSize: 14.sp, color: Color(0xFF9EA6BA)),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
