// import 'package:flutter/material.dart';
// import 'package:heal2gether/utils.dart/utils.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 0, 10, 150),
//         title: Text(
//           'Profile', // Replace with the appropriate username
//         ),
//         centerTitle: false,
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.grey,
//                       // Replace with appropriate image source
//                       backgroundImage: AssetImage('path/to/image'),
//                       radius: 40,
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               buildStatColumn(0,
//                                   "posts"), // Replace with the appropriate post count
//                               buildStatColumn(0,
//                                   "followers"), // Replace with the appropriate follower count
//                               buildStatColumn(0,
//                                   "following"), // Replace with the appropriate following count
//                             ],
//                           ),
//                           // Add the appropriate buttons or widgets based on your requirements
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Add the remaining user details based on your requirements
//               ],
//             ),
//           ),
//           const Divider(),
//           // Add the appropriate widgets or components to display user posts
//         ],
//       ),
//     );
//   }

//   Column buildStatColumn(int num, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           num.toString(),
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Glacial Indifference',
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(top: 4),
//           child: Text(
//             label,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w400,
//               color: Colors.grey,
//               fontFamily: 'Glacial Indifference',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
