import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_model.dart';

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
    //cont track ..notify data change
    return FirebaseFirestore.instance.collection("blogs").snapshots();
  }

  Stream<List<BlogModel>> get getBlogs {
    //fetch
    return FirebaseFirestore.instance.collection("blogs").snapshots().map(
        (QuerySnapshot querySnapshot) =>
            querySnapshot.docs //syntax//use for mapping
                .map((DocumentSnapshot documentSnapshot) => BlogModel(
                      authorName:
                          (documentSnapshot.data()! as Map<String, dynamic>)[
                                  'authorName'] ?? //?? this solve null error
                              "", //default val besides null
                      desc: (documentSnapshot.data()!
                              as Map<String, dynamic>)['desc'] ??
                          "",
                      title: (documentSnapshot.data()!
                              as Map<String, dynamic>)['title'] ??
                          "",
                      imageUrl: (documentSnapshot.data()!
                              as Map<String, dynamic>)['imgUrl'] ??
                          "",
                    ))
                .toList());
  }
}
