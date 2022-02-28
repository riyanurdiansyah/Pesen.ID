import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  Stream<QuerySnapshot<Map<String, dynamic>>> streamLapangan() {
    return FirebaseFirestore.instance.collection("/Lapangan").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMitra() {
    return FirebaseFirestore.instance.collection("/Mitra").snapshots();
  }
}
