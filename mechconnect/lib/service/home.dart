import 'package:flutter/material.dart';
import 'package:mechconnect/service/add.dart';
import 'package:mechconnect/service/register.dart';
import 'package:mechconnect/service/viewcomplaint.dart';
import 'package:mechconnect/service/viewfeedback.dart';
import 'package:mechconnect/service/viewrequest.dart';
import 'package:mechconnect/service/viewstatus.dart';
import 'package:mechconnect/user/login.dart';

void main() {
  runApp(homeservice());
}

class homeservice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen1());
  }
}String? serviceid;


class HomeScreen1 extends StatefulWidget {

  
  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  Future<void> posthome(context) async {
    try {
     

      final response = await dio.get(
        "$baseurl/api/service/home/$loginid",
        
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
serviceid=response.data['_id'];
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Successful")));

     
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed")));
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
    posthome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6eef3),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// APP TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "MechConnect",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.settings, color: Colors.green),
                  ],
                ),

                SizedBox(height: 25),

                /// GRID BUTTONS
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Viewrequest(),
                          ),
                        );
                      },
                      child: buildMenuButton(Icons.list_alt, "MANAGE REQUESTS"),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Add()),
                        );
                      },
                      child: buildMenuButton(Icons.person_add, "ADD PERSONNEL"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Viewcomplaint(),
                          ),
                        );
                      },
                      child: buildMenuButton(
                        Icons.chat_bubble_outline,
                        "VIEW COMPLAINTS",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Viewstatus()),
                        );
                      },
                      child: buildWhiteButton(
                        Icons.access_time,
                        "UPDATE STATUS",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Viewfeedback(),
                          ),
                        );
                      },
                      child: buildWhiteButton(Icons.star, "FEEDBACK"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: buildMenuButton(Icons.logout, "LOG OUT"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Blue button
  Widget buildMenuButton(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff4e6e88),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// White button
  Widget buildWhiteButton(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green, size: 32),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
