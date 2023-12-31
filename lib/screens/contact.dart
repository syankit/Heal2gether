import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 191, 235, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 119, 128),
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: const Color.fromARGB(255, 181, 232, 255),
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              ContactUsBubble(
                icon: Icons.email_sharp,
                info: 'heal2gether@gmail.com',
              ),
              ContactUsBubble(
                icon: Icons.call_rounded,
                info: '+91 1122334455',
              ),
              ContactUsBubble(
                icon: FontAwesomeIcons.instagram,
                info: 'www.instagram.com/heal2gether',
              ),
              ContactUsBubble(
                icon: FontAwesomeIcons.facebook,
                info: 'www.facebook.com/heal2gether',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleTextLogo extends StatelessWidget {
  final Size size;
  final String title;

  const SingleTextLogo({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: size.width,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ContactUsBubble extends StatelessWidget {
  final IconData icon;
  final String info;

  const ContactUsBubble({
    Key? key,
    required this.icon,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(icon),
        title: Text(info),
      ),
    );
  }
}
