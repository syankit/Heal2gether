import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heal2gether/gobal.dart';
import 'package:heal2gether/models/blog_model.dart';
import 'package:heal2gether/screens/blog_write.dart';
import 'package:heal2gether/screens/contact.dart';
import 'package:heal2gether/screens/login.dart';
import 'package:heal2gether/screens/openblog.dart';
import 'package:heal2gether/screens/profile/profile.dart';
import 'package:heal2gether/screens/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:heal2gether/screens/search.dart';
import 'package:heal2gether/widgets/blogmap.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  static String id = 'blog_page';

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Stream<QuerySnapshot> blogsStream;
  final _search = TextEditingController();
  CrudMethods crudMethods = CrudMethods(); // Create an instance of CrudMethods
  List<BlogModel> blogs = [];

  @override
  void initState() {
    super.initState();
    blogsStream = crudMethods
        .getData()
        .asBroadcastStream(); // Call getData() on the instance
    /* crudMethods.getData().then(
      (result) {
        setState(() {
          blogsStream = result;
        });
      },
    );*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _showSettingsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(
                  'Personal Info',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 10, 150),
                  ),
                ),
                onTap: () {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    final uid = currentUser.uid;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: uid),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 10, 150),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Add Blog',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 10, 150),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => blog_write(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void searchUser() {
    final userId = _search.text;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    userRef.get().then((snapshot) {
      if (snapshot.exists) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(userId),
          ),
        );
      } else {
        // Handle case when user profile doesn't exist
      }
    }).catchError((error) {
      // Handle error if occurred while fetching user profile data
    });
  }

  void openBlog(BlogModel blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OpenBlog(blog: blog),
      ),
    );
  }

  Widget BlogsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: blogs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final data = blogs[index];
        return GestureDetector(
          onTap: () => openBlog(data),
          child: BlogsTile(
            authorName: data.authorName,
            title: data.title,
            imgUrl: data.imageUrl,
          ),
        );
      },
    );
  }

  void printBlog(BlogModel b) {
    print(b.authorName);
    print(b.title);
    print(b.desc);
    print(b.imageUrl);
    print(b.uid);
    print("...........");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(size);
    blogs = Provider.of<List<BlogModel>>(
        context); //sytax for fetching data from provider
    blogs.forEach((b) => printBlog(b));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 146, 155),
        leadingWidth: 180,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Text(
              'Blog Page',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Pacifico',
                fontSize: 25,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showSettingsDialog,
            icon: Icon(
              Icons.settings,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(color: Colors.white70, width: 50.0),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Expanded(
                child: BlogsList(),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 100,
              right: 100,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 0, 8, 122),
                ),
                child: Center(
                  child: TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_circle_outline_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 0),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => blog_write(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, authorName;

  BlogsTile({
    required this.imgUrl,
    required this.title,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 170,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(0, 247, 245, 245),
                BlendMode.xor,
              ),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  authorName,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final String userId;

  UserProfileScreen(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Text('User Profile Details for ID: $userId'),
        // Display the user profile details using the fetched data
      ),
    );
  }
}
