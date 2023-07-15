import 'package:flutter/material.dart';
import 'package:heal2gether/gobal.dart';
import 'package:heal2gether/screens/contact.dart';
import 'package:heal2gether/screens/login.dart';
import 'package:heal2gether/screens/signup.dart';

class Newuser extends StatelessWidget {
  const Newuser({super.key});

  static String id = 'No_User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 16, 139),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 146, 155),
        leadingWidth: 200,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Lets Heal & Grow Together !',
              style: TextStyle(
                color: const Color.fromARGB(226, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontFamily: 'Glacial Indifference',
                fontSize: 14.6,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ContactUsPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.contact_page_outlined,
                color: Colors.white70,
                size: 30,
              )),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 350,
                  child: Image(image: AssetImage("assets/logo.gif")),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 146, 155),
                  // Set the background color to blue
                ),
                child: Text('Sign Up'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 16, 146, 155), // Set the background color to blue
                ),
                child: const Text(
                  'Log In ',
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
