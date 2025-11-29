import 'package:flutter/material.dart';
import 'package:mechconnect/user/report.dart';

class Viewservicecenter extends StatelessWidget {
  Viewservicecenter({super.key});
  List<dynamic> Service = [
    {
      "Service center name": "theertha service center",
      "contact": 2345678,
      "email": "fgohj@gmail.com",
      "location": "kattangal",
    },
    {
      "Service center name": "isha service center",
      "contact": 23458,
      "email": "fghj@gmail.com",
      "location": "kannur",
    },
    {
      "Service center name": "hina service center",
      "contact": 345678,
      "email": "fgj@gmail.com",
      "location": "kollam",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service center details"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Service.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Report()),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: const Color.fromARGB(167, 0, 0, 0),size: 20,
                        ),
                        title: Text(Service[index]["Service center name"]),
                        subtitle: Column(
                          children: [
                            Text(Service[index]["contact"].toString()),
                            Text(Service[index]["email"]),
                            Text(Service[index]["location"]),
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
