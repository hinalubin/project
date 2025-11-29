import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});
  List<dynamic> Notification = [
    {"service center": "theertha", "status": "your request accepted","Date":"13-08-25"},
    {"service center": "hina", "status": "your request rejected","Date":"03-09-25"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Notification.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(trailing: Text(Notification[index]["Date"]),
                      title: Text(Notification[index]["service center"]),
                      subtitle: Column(
                        children: [
                          Text(Notification[index]["status"]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
