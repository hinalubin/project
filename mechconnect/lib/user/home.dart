import 'package:flutter/material.dart';
import 'package:mechconnect/service/register.dart';
import 'package:mechconnect/user/addvehicle.dart';

import 'package:mechconnect/user/chatbot.dart';
import 'package:mechconnect/user/login.dart';
import 'package:mechconnect/user/notifications.dart';
import 'package:mechconnect/user/pickup.dart';
import 'package:mechconnect/user/tracking.dart';
import 'package:mechconnect/user/viewpayment.dart';
import 'package:mechconnect/user/viewservicecenter.dart';

void main() {
  runApp(MechConnectApp());
}

class MechConnectApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}



  String? userid;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> getuser(context) async {
    try {
     

      final response = await dio.get(
        "$baseurl/api/user/home/$loginid",
        
      );

      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        userid=response.data['data']['_id'];
        print(userid);
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
    getuser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------------------- APP BAR -------------------------
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            Icon(Icons.settings, color: Colors.white),
            SizedBox(width: 8),
            Text("Mech Connect", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          SizedBox(width: 15),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
            icon: Icon(Icons.notifications_none),
            color: Colors.white,
          ),
          SizedBox(width: 10),
        ],
      ),

      // ------------------------- BODY -------------------------
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, Hina,isha,theertha!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            Text(
              "Your Vehicles: 2",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            SizedBox(height: 20),

            // ------------------------- BUTTON GRID -------------------------
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                // ----- My Vehicles -----
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Addvehicle()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "My Vehicles",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ----- Service Centers -----
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Viewservicecenter(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.apartment, size: 40, color: Colors.blue),
                          SizedBox(height: 10),
                          Text(
                            "Service Centers",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ----- Report Issue -----
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pickup()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.car_repair_outlined,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Pickup",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ----- Track Mechanic -----
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Trackingpage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search,
                            size: 40,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tracking",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            // ------------------------- LOWER OPTIONS -------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Viewpayment()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.attach_money_sharp,
                        size: 28,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 4),
                      Text("Payment", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 28,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 4),
                      Text("Chat Support", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
