import 'package:flutter/material.dart';
import 'package:mechconnect/service/register.dart';
import 'package:mechconnect/user/home.dart';
import 'package:mechconnect/user/login.dart';

class Viewvehicle extends StatefulWidget {
  Viewvehicle({super.key});

  @override
  State<Viewvehicle> createState() => _ViewvehicleState();
}

class _ViewvehicleState extends State<Viewvehicle> {
  List<dynamic> vehicles = [];

  // Fetch vehicles
  Future<void> getvehicle(context) async {
    try {
      final response = await dio.get("$baseurl/api/vehicle/$userid");

      print("Vehicle API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          vehicles = response.data['data']; // ✅ Correct
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to load vehicles")));
      }
    } catch (e) {
      print("❌ Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    getvehicle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Details"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: vehicles.isEmpty
          ? Center(child: Text("No vehicles found"))
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: const Color.fromARGB(105, 158, 158, 158),
                    child: ListTile(
                      title: Text(
                        "Number: ${vehicle["vehicleNumber"]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text("Brand: ${vehicle["brand"]}"),
                          Text("Model: ${vehicle["model"]}"),
                          Text("Fuel: ${vehicle["fuelType"]}"),
                          Text("Type: ${vehicle["vehicleType"]}"),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // Delete function can be added here
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
