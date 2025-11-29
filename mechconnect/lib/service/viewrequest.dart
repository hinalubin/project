import 'package:flutter/material.dart';
import 'package:mechconnect/service/mechanics.dart';
import 'package:mechconnect/service/pickups.dart';

class Viewrequest extends StatefulWidget {
  Viewrequest({super.key});

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

class _ViewrequestState extends State<Viewrequest> {
  List<dynamic> Request = [
    {"issue": "theertha issue ", "location": "kattangal", "accepted": false},
    {"issue": "isha issue ", "location": "kannur", "accepted": false},
    {"issue": "hina issue ", "location": "kollam", "accepted": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Request ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Request.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        title: Text(Request[index]["issue"]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Request[index]["location"]),

                            // -------------------------
                            // CONDITION HERE 👇
                            // -------------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: Request[index]["accepted"] == false
                                  ? [
                                      /// ACCEPT BUTTON
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Request[index]["accepted"] = true;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                            195,
                                            76,
                                            175,
                                            79,
                                          ),
                                        ),
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10),

                                      /// REJECT BUTTON
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                            196,
                                            244,
                                            67,
                                            54,
                                          ),
                                        ),
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [
                                      /// MECHANIC BUTTON
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Assign(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Mechanic",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                      ),

                                      SizedBox(width: 10),

                                      /// PICK UP BUTTON
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Pickups(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Pick Up",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                        ),
                                      ),
                                    ],
                            ),
                          ],
                        ),
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
