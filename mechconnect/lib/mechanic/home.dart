import 'package:flutter/material.dart';
import 'package:mechconnect/mechanic/assignedtask.dart';
import 'package:mechconnect/user/login.dart';

class Homemechanic extends StatelessWidget {
  const Homemechanic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6eef3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Assignedtask()),
                  );
                },
                icon: Icon(Icons.task_alt, color: Colors.blue),
                label: Text(
                  "ASSIGNED TASK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: Size(double.infinity, 80),
                ),
              ),
              SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                icon: Icon(Icons.logout_outlined, color: Colors.blue),
                label: Text(
                  "LOG OUT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: Size(double.infinity, 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
