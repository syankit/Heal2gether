import 'package:flutter/material.dart';
import 'package:heal2gether/gobal.dart';

class BlogList extends StatelessWidget {
  final title;
  final written;
  final image;

  const BlogList(
      {Key? key,
      required this.title,
      required this.written,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 2, 2, 2)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Image.asset(
                    image,
                    width: 400,
                    height: 210,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 109, 13, 13),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Rakkas', color: kDarkBlue),
                  ),
                  Text(
                    'By: $written',
                    style: TextStyle(
                        fontSize: 12, fontFamily: 'Rakkas', color: kDarkBlue),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
