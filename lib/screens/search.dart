import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heal2gether/screens/blog.dart';
import 'package:heal2gether/screens/profile/profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 119, 128),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlogPage(),
              ),
            );
          },
        ),
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search here',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
                print(_);
              },
            ),
          ),
          Expanded(
            child: isShowUsers
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where(
                          'username',
                          isGreaterThanOrEqualTo: searchController.text,
                        )
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  uid: (snapshot.data! as dynamic).docs[index]
                                      ['uid'],
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['photoUrl'],
                                ),
                                radius: 24,
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .orderBy('datePublished')
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) => Image.network(
                          (snapshot.data! as dynamic).docs[index]['postUrl'],
                          fit: BoxFit.cover,
                        ),
                        staggeredTileBuilder: (index) =>
                            MediaQuery.of(context).size.width > 20
                                ? StaggeredTile.count(
                                    (index % 7 == 0) ? 1 : 1,
                                    (index % 7 == 0) ? 1 : 1,
                                  )
                                : StaggeredTile.count(
                                    (index % 7 == 0) ? 2 : 1,
                                    (index % 7 == 0) ? 2 : 1,
                                  ),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
