import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{

  Future<Stream<DocumentSnapshot>> getData() async{
    return Firestore.instance.collection("blogs").document("BJCHiT1YNwJbyU3Y4tHJ").snapshots();
  }
}