import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VehicleListPage(),
    );
  }
}

class VehicleListPage extends StatefulWidget {
  @override
  _VehicleListPageState createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _firebaseService.getVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> vehicles = snapshot.data ?? [];
            return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(vehicles[index]['model']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VehicleDetailsPage(vehicle: vehicles[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddVehiclePage
          // You can implement the page to add a new vehicle here.
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class VehicleDetailsPage extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  VehicleDetailsPage({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Model: ${vehicle['model']}'),
          Text('Color: ${vehicle['color']}'),
          Text('Wheel Type: ${vehicle['wheelType']}'),
          Text('Manufacturing Year: ${vehicle['manufacturingYear']}'),
          // Add other details here
        ],
      ),
    );
  }
}

