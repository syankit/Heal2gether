import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heal2gether/gobal.dart';
import 'package:heal2gether/screens/blog_write.dart';
import 'package:heal2gether/screens/contact.dart';
import 'package:heal2gether/screens/login.dart';
import 'package:heal2gether/screens/profile.dart';
import 'package:heal2gether/widgets/blogcard.dart';
import 'package:heal2gether/widgets/bloglist.dart';
import 'package:heal2gether/screens/profile.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  static String id = 'blog_page';

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _showSettingsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
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
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                fontSize: 28,
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
        //color: Colors.grey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Color.fromARGB(255, 204, 255, 252),
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      labelText: 'Search for your desire blog',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(color: Colors.white70, width: 50.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 214, 255, 252),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BlogCard(
                          title: 'All Blogs',
                          color: Colors.yellow,
                          borderColor: Colors.black.withOpacity(0.4),
                          cardOpacity: 0.8,
                        ),
                        BlogCard(
                          title: 'Covid-19 Related',
                          color: Colors.lightGreenAccent,
                          borderColor: Colors.black.withOpacity(0.4),
                          cardOpacity: 0.8,
                        ),
                        BlogCard(
                          title: 'Lifestyle Related',
                          color: Colors.lightBlueAccent,
                          borderColor: Colors.black.withOpacity(0.4),
                          cardOpacity: 0.8,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Expanded(
                  child: ListView.builder(
                      itemCount: BLOG_DATA.length,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BlogList(
                            title: BLOG_DATA[index]["title"],
                            written: BLOG_DATA[index]["written"],
                            image: BLOG_DATA[index]["image"]);
                      }),
                )
              ],
            ),
            Positioned(
              bottom: 30,
              left: 100,
              right: 100,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 0, 8, 122)),
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
