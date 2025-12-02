import 'package:flutter/material.dart';

class Pickup extends StatelessWidget {
  Pickup({super.key});
  List<dynamic> Pickups = [
    {
      "Name": "miras",
      "Phone number": 98765432,
      "Email id": "hjk@gmail.com",
      "location": "kjhgfd",
    },
    {
      "Name": "Sachin",
      "Phone number": 8765432,
      "Email id": "jk@gmail.com",
      "location": "kjhd",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pickup details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Pickups.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: const Color.fromARGB(97, 196, 208, 215),
                    child: ListTile(
                      title: Text(
                        Pickups[index]["Name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Request",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 3, 31, 55),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            206,
                            220,
                            226,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(Pickups[index]["Phone number"].toString()),
                          Text(Pickups[index]["Email id"]),
                          Text(Pickups[index]["location"]),
                        ],
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
