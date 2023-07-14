import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heal2gether/gobal.dart';
import 'package:heal2gether/resources/auth.dart';
import 'package:heal2gether/screens/blog.dart';
import 'package:heal2gether/screens/newuser.dart';
import 'package:heal2gether/screens/signup.dart';
import 'package:heal2gether/utils.dart/utils.dart';
import 'package:heal2gether/widgets/text_design.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_page';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Auth().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      // navigate to the blog screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BlogPage(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 16, 139),
      body: SafeArea(
        child: SingleChildScrollView(
          //avoid bottom overflow
          physics: BouncingScrollPhysics(), // Add BouncingScrollPhysics()
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //img
                Container(
                  height: 350,
                  child: Image(image: AssetImage("assets/logo.gif")),
                ),
                const SizedBox(
                  height: 0,
                ),
                //email
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(color: Colors.white70, width: 20.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                ),
                //password
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0), // Adjust the padding as needed
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                ),
                /*TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),*/
                //button
                const SizedBox(
                  height: 14,
                ),

                InkWell(
                  child: Container(
                    child: !_isLoading
                        ? const Text(
                            'Log in',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : const CircularProgressIndicator(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Color.fromARGB(255, 16, 146, 155),
                    ),
                  ),
                  onTap: loginUser,
                ),
                const SizedBox(
                  height: 0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Dont have an account?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 78),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      ),
                      child: Container(
                        child: const Text(
                          ' Signup.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 16, 146, 155),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
