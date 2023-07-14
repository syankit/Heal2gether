import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heal2gether/resources/auth.dart';
import 'package:heal2gether/screens/blog.dart';
import 'package:heal2gether/screens/login.dart';
import 'package:heal2gether/screens/newuser.dart';
import 'package:heal2gether/utils.dart/utils.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await Auth().SignUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

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

  Future<void> selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);

    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 16, 139),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 54,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor:
                                const Color.fromARGB(255, 0, 230, 247),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            backgroundColor:
                                const Color.fromARGB(255, 0, 210, 247),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Color.fromARGB(255, 20, 154, 163),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(color: Colors.white70, width: 20.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.text,
                  controller: _userController,
                  style: const TextStyle(color: Colors.white),
                ),
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
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                ),
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
                      borderSide:
                          BorderSide(color: Colors.white70, width: 20.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your bio',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.text,
                  controller: _bioController,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: !_isLoading
                        ? const Text(
                            'Sign up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : const CircularProgressIndicator(
                            color: Color.fromARGB(255, 245, 245, 245),
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
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account!!!',
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                      child: Container(
                        child: const Text(
                          ' Login.',
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
