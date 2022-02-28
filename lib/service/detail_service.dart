import 'package:cloud_firestore/cloud_firestore.dart';

class DetailService {
  Stream<QuerySnapshot<Map<String, dynamic>>> streamBooking(String id) {
    return FirebaseFirestore.instance
        .collection("/Booking")
        .where("idLapangan", isEqualTo: id)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchMitraByID(
      String _id) async {
    return FirebaseFirestore.instance.collection("/Mitra").doc(_id).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDetailMitra(
      String _id) async {
    return FirebaseFirestore.instance
        .collection("/Mitra")
        .doc(_id)
        .collection("detail")
        .get();
  }
}
