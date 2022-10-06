import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/speechRecognition/speechFAB.dart';
import 'package:provider/provider.dart';

import '../authentication/loginUI.dart';
import '../my_flutter_app_icons.dart';

class profileUI extends StatefulWidget {
  const profileUI({Key? key}) : super(key: key);

  @override
  State<profileUI> createState() => _profileUIState();
}

class _profileUIState extends State<profileUI> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            width: 40,
                            child: Hero(
                              tag: "logo",
                              child: Image.asset("assets/images/PharmaGo_rounded.png"),

                            ),
                          ),
                          Text(
                            "Welcome ${context.watch<registerProvider>().Name.split(" ")[0]}",
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        MyFlutterApp.bell,
                        color: Color(0xff219C9C),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
                          child: Center(
                            child: Text(
                              "${context.watch<registerProvider>().Name}",
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ),
                        ),

                        const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 150,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color(0xffD9DEDC)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mobile Number: ${context.watch<registerProvider>().Number}",
                                style: const TextStyle(
                                  fontSize: 14
                                ),
                              ),
                              Text(
                                "Age:  ${context.watch<registerProvider>().Age}",
                                style: const TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              Text(
                                "Height:  ${context.watch<registerProvider>().Height}",
                                style: const TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              Text(
                                "Weight:  ${context.watch<registerProvider>().Weight}",
                                style: const TextStyle(
                                    fontSize: 14
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 75,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Color(0xffD9DEDC)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Logout of account",
                                style: TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  FirebaseAuth.instance.signOut();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff219C9C),
                                  elevation: 0,
                                  fixedSize: Size(100, 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                                child: Text(
                                  "Logout",
                                ),
                              )
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: const speechFAB()
    );
  }
}