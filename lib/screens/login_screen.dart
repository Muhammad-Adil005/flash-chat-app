import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../services/auth_services.dart';
import '../widgets/custom_button.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.h,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                /*onChanged: (value) {
                  //Do something with the user input.
                },*/
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                /*onChanged: (value) {},*/
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomButton(
                color: Colors.lightBlueAccent,
                text: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  User? user = await AuthService()
                      .signIn(emailController.text, passwordController.text);
                  if (user != null) {
                    Get.to(
                      () => ChatScreen(),
                    ); // Navigate to ChatScreen if login is successful
                    setState(() {
                      showSpinner = false;
                    });
                  } else {
                    Get.snackbar('Error',
                        'Failed to log in'); // Show error using GetX snackbar
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
