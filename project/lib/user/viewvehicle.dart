import 'package:flutter/material.dart';

class Viewvehicle extends StatelessWidget {
  Viewvehicle({super.key});
  List<dynamic> vehicles = [
    {
      "vehicle number": "KL 57 3431",
      "Vehicle model": "Royal Enfield Hunter 350",
      "Vehicle type": "Two wheeler",
    },
    {
      "vehicle number": "KL 57 7856",
      "Vehicle model": "Benz 90",
      "Vehicle type": "Four wheeler",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle details"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(color: const Color.fromARGB(105, 158, 158, 158),
                    child: ListTile(
                      title: Text(vehicles[index]["vehicle number"]),
                      subtitle: Column(
                        children: [
                          Text(vehicles[index]["Vehicle model"]),
                          Text(vehicles[index]["Vehicle type"]),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          
                        },
                        icon: Icon(Icons.delete,color: Colors.red,),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
