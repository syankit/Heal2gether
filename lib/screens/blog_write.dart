import 'dart:typed_data';
import 'dart:io';
import 'dart:math';
import 'package:heal2gether/screens/blog.dart';
import 'package:heal2gether/widgets/blogmap.dart';
import 'package:random_x/random_x.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heal2gether/utils.dart/utils.dart';

class blog_write extends StatefulWidget {
  const blog_write({super.key});
  static String id = 'blog_page';
  @override
  State<blog_write> createState() => _blog_writeState();
}

class _blog_writeState extends State<blog_write> {
  dynamic authorName, title, desc;
  PickedFile? selectedImage;
  bool _isLoading = false;

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = PickedFile(image.path);
      });
    }
  }

  void uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      // navigate to the blog screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BlogPage(),
        ),
      );

      /// uploading image to firebase storage
      FirebaseStorage storage = FirebaseStorage.instance;
      String randomString = String.fromCharCodes(
          List.generate(9, (index) => Random().nextInt(26) + 97));
      Reference storageRef =
          storage.ref().child("blogImages").child("$randomString.jpg");
      File imageFile = File(selectedImage!.path);
      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, dynamic> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc
      };
      CrudMethods().addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 205, 219),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Write",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(
                  fontSize: 22, color: const Color.fromARGB(255, 3, 56, 100)),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.file_upload,
                color: Color.fromARGB(255, 2, 73, 131),
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 125,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Author Name",
                            hintStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                  color: Colors.white70, width: 20.0),
                            ),
                          ),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                  color: Colors.white70, width: 20.0),
                            ),
                          ),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                  color: Colors.white70, width: 20.0),
                            ),
                          ),
                          onChanged: (val) {
                            desc = val;
                          },
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 56, 100),
                      // Set the background color to blue
                    ),
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BlogPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
