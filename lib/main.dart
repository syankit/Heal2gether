import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:heal2gether/models/blog_model.dart';
import 'package:heal2gether/screens/blog.dart';
import 'package:heal2gether/screens/login.dart';
import 'package:heal2gether/screens/newuser.dart';
import 'package:heal2gether/screens/search.dart';
import 'package:provider/provider.dart';
import 'package:heal2gether/widgets/blogmap.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //This line ensures that the Flutter binding is properly initialized. It is necessary to call this method before using any Flutter framework features.
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User? user = FirebaseAuth.instance
      .currentUser; //This line declares a nullable variable named user of type User, which is the current user object from Firebase Authentication. The FirebaseAuth.instance.currentUser retrieves the currently authenticated user, or null if there is no authenticated user.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //statemangement -->make common database -->showcase data to desired screen
      providers: [
        StreamProvider<List<BlogModel>>.value(
          //syntax for register
          value: CrudMethods().getBlogs,
          initialData: const [],
        )
      ],
      child: MaterialApp(
        home: user == null ? Newuser() : BlogPage(),
        //home: SearchScreen(),
      ),
    );
  }
}
