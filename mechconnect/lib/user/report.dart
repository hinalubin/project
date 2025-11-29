import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechconnect/user/complaint.dart';
import 'package:mechconnect/user/feedback.dart';


class Report extends StatefulWidget {
  Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController report = TextEditingController();

  final formkey = GlobalKey<FormState>();
  File? image;
  final ImagePicker picker = ImagePicker();
  Future<void> pickimage() async {
    final XFile? pickedfile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    pickimage();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null ? Icon(Icons.camera) : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: report,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your details";
                    }
                  },
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Enter your issues",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      'data done';
                    }
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Complaint()),
                    );
                  },
                  child: Text(
                    "Complaint",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Feedbackpage()),
                    );
                  },
                  child: Text(
                    "Feedback",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
