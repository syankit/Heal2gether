import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(Map<String, dynamic> blogData) async {
    try {
      await FirebaseFirestore.instance.collection("blogs").add(blogData);
      print("Data added successfully.");
    } catch (error) {
      print("Error adding data: $error");
    }
  }

  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection("blogs").snapshots();
  }
}
