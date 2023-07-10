import 'package:flutter/material.dart';
import 'package:heal2gether/gobal.dart';

class BlogCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color borderColor;
  final double cardOpacity;

  const BlogCard({
    required this.title,
    required this.color,
    required this.borderColor,
    required this.cardOpacity,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color.withOpacity(cardOpacity),
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors
                      .black, // Replace 'Colors.black' with the desired text color
                  fontFamily: 'Rakkas',
                ),
              ),
            ),
          )),
    );
  }
}
