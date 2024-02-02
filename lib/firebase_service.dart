import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getVehicles() async {
    QuerySnapshot snapshot = await _firestore.collection('vehicles').get();
    return snapshot.docs.map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<void> addVehicle(Map<String, dynamic> vehicle) async {
    await _firestore.collection('vehicles').add(vehicle);
  }
}