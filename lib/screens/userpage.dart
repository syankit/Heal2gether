import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heal2gether/gobal.dart';
import 'package:heal2gether/screens/newuser.dart';

class UserPage extends StatefulWidget {
  static String id = 'User_Page';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: kPrimaryColor, unselectedWidgetColor: Colors.white),
        home: Scaffold(
          appBar: AppBar(
            leadingWidth: 180,
            leading: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    color: kPurple,
                    fontFamily: 'Pacifico',
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, Newuser.id);
                  },
                  icon: Icon(
                    Icons.settings,
                    color: kPurple,
                    size: 30,
                  )),
            ],
          ),
        ));
  }
}
