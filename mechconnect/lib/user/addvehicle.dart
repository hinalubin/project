import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mechconnect/service/register.dart';
import 'package:mechconnect/user/home.dart';
import 'package:mechconnect/user/viewvehicle.dart';

class Addvehicle extends StatefulWidget {
  const Addvehicle({super.key});

  @override
  State<Addvehicle> createState() => _AddvehicleState();
}

class _AddvehicleState extends State<Addvehicle> {
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  
  final TextEditingController yearController = TextEditingController();
  final TextEditingController vehicleBrandController=TextEditingController();
  

  String? selectedtype;
  String? selectedFuelType;

 

  final List<String> fuelTypes = [
    "Petrol",
    "Diesel",
    "Electric",
    "Hybrid",
    "CNG"
  ];
  final List<String> type = [
    "two-wheeler",
    "three-wheeler",
    "four-wheeler",
    "heavy vehicles",
    
  ];
  Future<void> addvehicle(context) async {
    try {
      final response = await dio.post(
        "$baseurl/api/vehicle/register",

        data:{ "userId":userid,
        "brand":vehicleBrandController.text,
        "model":vehicleModelController.text,
        "vehicleNumber":vehicleNumberController.text,
        "fuelType":selectedFuelType,
        "vehicleType":selectedtype
        }
        
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("vehicle added Successful")));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Viewvehicle()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(" Failed")));
      }
    } catch (e) {
      print("❌ Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add your vehicles",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Vehicle Number
            TextFormField(
              controller: vehicleNumberController,
              decoration: InputDecoration(
                label: Text("Vehicle number"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: vehicleBrandController,
              decoration: InputDecoration(
                label: Text("Vehicle brand"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Vehicle Model
            TextFormField(
              controller: vehicleModelController,
              decoration: InputDecoration(
                label: Text("Vehicle model"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Vehicle Type
           

            // Brand Dropdown
           
            // Fuel Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedFuelType,
              decoration: InputDecoration(
                label: Text("Fuel Type"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: fuelTypes
                  .map((fuel) =>
                      DropdownMenuItem(value: fuel, child: Text(fuel)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFuelType = value;
                });
              },
            ),
            SizedBox(height: 20),
             DropdownButtonFormField<String>(
              value: selectedtype,
              decoration: InputDecoration(
                label: Text("Vehicle Type"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: type
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedtype = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Year
            TextFormField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Year"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    addvehicle(context);
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Viewvehicle()),
                    );
                  },
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}