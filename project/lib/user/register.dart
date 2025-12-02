import 'package:flutter/material.dart';
import 'package:project/user/login.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController Name = TextEditingController();
  TextEditingController Contact = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool visible = true;
  bool visible1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
      ),

      body: SafeArea(
        child: SingleChildScrollView(            // 🔥 FIX OVERFLOW
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 15),

                  // NAME
                  TextFormField(
                    controller: Name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 15),

                  // CONTACT
                  TextFormField(
                    controller: Contact,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your contact";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Contact"),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 15),

                  // EMAIL
                  TextFormField(
                    controller: Email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email";
                      } 
                      if (!value.contains("@") || !value.endsWith("@gmail.com")) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // PASSWORD
                  TextFormField(
                    controller: Password,
                    obscureText: visible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a password";
                      }
                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          visible
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // CONFIRM PASSWORD
                  TextFormField(
                    controller: ConfirmPassword,
                    obscureText: visible1,
                    validator: (value) {
                      if (value != Password.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Confirm Password"),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          visible1
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            visible1 = !visible1;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  // BUTTON
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // ALREADY HAVE ACCOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
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

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
