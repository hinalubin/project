import 'package:flutter/material.dart';

class History extends StatelessWidget {
  History({super.key});

  // Corrected list variable name
  final List<Map<String, dynamic>> historys = [
    {
      "service center": "theertha",
      "assign": "mechanic",
      "Mechanic name": "john",
      "Date": "13-08-25",
      "issue": "issue1",
      "status": "Completed"
    },
    {
      "pickup": "hina",
      "status": "Your request rejected",
      "Date": "03-09-25"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
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
                itemCount: historys.length,
                itemBuilder: (context, index) {
                  final item = historys[index];

                  return Card(
                    child: ListTile(
                      trailing: Text(item["Date"] ?? ""),
                      title: Text(item["service center"] ?? item["pickup"] ?? "No Name"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item["status"] ?? item["issue"] ?? ""),
                          if (item["assign"] != null)
                            Text("Assigned to: ${item["Mechanic name"] ?? ""}"),
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
