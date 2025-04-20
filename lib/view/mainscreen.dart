import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getalife/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:loading_gifs/loading_gifs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Results user = Results();
  bool userFetched = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 220,
              child: Card(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: userFetched 
                        ? FadeInImage.assetNetwork(
                          image: '${user.picture?.large}',
                          placeholder: circularProgressIndicatorSmall,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(circularProgressIndicatorSmall);
                          },
                        )
                        : Text("No image") 
                      ),

                      // Name
                      Card(child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold)), 
                          Text("${user.name?.full}")
                        ],),
                      ),),

                      // Gender
                      Card(child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gender: ", style: TextStyle(fontWeight: FontWeight.bold)), 
                          Text("${user.gender}")
                        ],),
                      ),),

                      // Email
                      Card(child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email: ", style: TextStyle(fontWeight: FontWeight.bold)), 
                          Text("${user.email}")
                        ],),
                      ),),

                      // Address
                      Card(child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Address: ", style: TextStyle(fontWeight: FontWeight.bold)), 
                          Flexible(
                            child: Column(
                              children: [ 
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Text("${user.location?.address1}", textAlign: TextAlign.right,),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Text("${user.location?.address2}", textAlign: TextAlign.right,),
                                ),
                              ]
                            ),
                          )
                        ],),
                      ),),

                      // Coordinates
                      Card(child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Coordinates: ", style: TextStyle(fontWeight: FontWeight.bold)), 
                          Text("${user.location?.coordinates?.latitude}, ${user.location?.coordinates?.longitude}")
                        ],),
                      ),),

                      // Timezone
                      Card(child: Padding(padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Timezone: ", style: TextStyle(fontWeight: FontWeight.bold)), 
                          Flexible(
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Text(
                                "GMT${user.location?.timezone?.offset}, ${user.location?.timezone?.description}",
                                textAlign: TextAlign.right,
                              )
                            ),
                          ),
                        ],),
                      ),),

                    ],
                  ),
                ),
              ),
            ),

            // Get A Life button
            Container(
              padding: EdgeInsets.only(top: 8),
              height: 55,
              width: 335,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                onPressed: getUser, 
                child: Text("Get A Life")
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getUser() async {
    http.get(Uri.parse("https://randomuser.me/api/")).then((response) {
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);

        setState(() {
          user = User.fromJson(jsondata).results![0];
          userFetched = true;
        });
      } else {
        //error
      }
    });
  }
}