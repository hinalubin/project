
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechconnect/user/login.dart';

class Registerservice extends StatefulWidget {
  Registerservice({super.key});

  @override
  State<Registerservice> createState() => _RegisterserviceState();
}
final baseurl='http://192.168.1.79:5000';
Dio dio=Dio();


class _RegisterserviceState extends State<Registerservice> {
  TextEditingController Name = TextEditingController();

  TextEditingController Contact = TextEditingController();

  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();
  TextEditingController img = TextEditingController(
    text: 'upload your certificate',
  );
  
  double? userLat,userLong;
  final formkey = GlobalKey<FormState>();
  bool visible = true;
  bool visible1 = true;
  File? image;
  final ImagePicker picker = ImagePicker();
  Future<void> pickimage() async {
    final XFile? pickedfile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);

        img.text = pickedfile.name;
      });
    }
  }
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are OFF");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions permanently denied");
    }
 
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      userLat = position.latitude;
      userLong = position.longitude;
    });

    print("📍 Latitude: $userLat, Longitude: $userLong");
  }
 Future<void> postReg(context) async {
    try {
      final formData = FormData.fromMap({
        'password': Password.text,
        'centerName': Name.text,
        'phone': Contact.text,
        'email': Email.text,
        'location': {'lat': userLat.toString(), 'lng': userLong.toString()},
        'certificateImg': await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
      });

      final response = await dio.post(
        "$baseurl/api/service/register",
        data: formData,
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registration Successful")));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registration Failed")));
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
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: Name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your name ";
                  }
                },
                decoration: InputDecoration(
                  label: Text("Name"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: Contact,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your contact";
                  }
                },
                decoration: InputDecoration(
                  label: Text("Contact"),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: Email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Email";
                  } else if (!value.contains("@") ||
                      !value.endsWith("@gmail.com")) {
                    return "Enter a valid email ";
                  }
                },
                decoration: InputDecoration(
                  label: Text("Email"),
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
                controller: Password,
                validator: (value) {
                  if (value == null) {
                    return "Enter a password";
                  } else if (value.length < 8) {
                    return "password must be 8 characters";
                  }
                },
                obscureText: visible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    icon: Icon(
                      visible ? Icons.visibility_off_rounded : Icons.visibility,
                    ),
                  ),
                  label: Text("Password"),
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
                controller: ConfirmPassword,
                validator: (value) {
                  if (value != Password.text) {
                    return "password doesn't match";
                  }
                },
                obscureText: visible1,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visible1 = !visible1;
                      });
                    },
                    icon: Icon(
                      visible1
                          ? Icons.visibility_off_rounded
                          : Icons.visibility,
                    ),
                  ),
                  label: Text("Confirm Password"),
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
                controller: img,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                    child: TextButton(
                      onPressed: () {
                        pickimage();
                      },
                      child: Text('Upload image'),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          134,
                          158,
                          158,
                          158,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (image != null) {
                      postReg(context);
                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("upload your certificate")),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have An Acoount ? "),
                  TextButton(
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
