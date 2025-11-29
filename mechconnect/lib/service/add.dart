import 'package:flutter/material.dart';
import 'package:mechconnect/user/report.dart';

class Add extends StatelessWidget {
  Add({super.key});
  List<dynamic> Adds = [
    {
      "name": "theertha ",
      "contact": 2345678,
      "email": "fgohj@gmail.com",
      "location": "kattangal",
      "type": "mech",
    },
    {
      "name": "isha ",
      "contact": 23458,
      "email": "fghj@gmail.com",
      "location": "kannur",
      "type": "pickup",
    },
    {
      "name": "hina ",
      "contact": 345678,
      "email": "fgj@gmail.com",
      "location": "kollam",
      "type": "mech",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request details"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Adds.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: ListTile(
                      title: Text(Adds[index]["name"]),
                      subtitle: Column(
                        children: [
                          Text(Adds[index]["contact"].toString()),
                          Text(Adds[index]["email"]),
                          Text(Adds[index]["location"]),
                          Text(Adds[index]["type"]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Accept",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
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
