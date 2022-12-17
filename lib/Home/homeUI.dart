import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pharma_go/Home/remindersDialog.dart';
import 'package:intl/intl.dart';

import 'package:pharma_go/Home/viewDialog.dart';
import 'package:pharma_go/authentication/loginUI.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:pharma_go/notification/NotificationUI.dart';
import 'package:pharma_go/speechRecognition/speechFAB.dart';
import 'package:provider/provider.dart';

import '../chat/chatUI.dart';

class homeUI extends StatefulWidget {
  const homeUI({Key? key}) : super(key: key);

  @override
  State<homeUI> createState() => _homeUIState();
}

class _homeUIState extends State<homeUI> {

  var recipes = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection("Reminders").orderBy("parsedTime");

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
                      onPressed: (){
                        showMaterialModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)
                              )
                          ),
                          context: context,
                          builder: (context) => const notifUI(),
                        );
                      },
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
                  padding: const EdgeInsets.only(top: 20, ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Need Assistance?",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Color(0xff424242),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(MyFlutterApp.support, color: Color(0xff219C9C)),
                                Text(
                                  "   Customer Service",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: chatUI(channelID: FirebaseAuth.instance.currentUser!.uid, Name: context.read<registerProvider>().Name),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff219C9C),
                                    elevation: 0,
                                    fixedSize: const Size(100, 30),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    )
                                  ),
                                  child: const Text(
                                    "Chat"
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reminders",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              showMaterialModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)
                                    )
                                ),
                                context: context,
                                builder: (context) => const reminderDialog(),
                              );
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                      Container(
                        height: 270,
                        child: StreamBuilder(
                            stream: recipes.snapshots(),
                            builder: (context,snapshot){
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return LoadingIndicator(size: 40, borderWidth: 2);
                              }

                              return ListView.builder(
                                itemCount:snapshot.data?.docs.length,
                                itemBuilder: (context,index){
                                  return Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        color: Color(0xffD9DEDC),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: (){
                                          showMaterialModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20)
                                                )
                                            ),
                                            context: context,
                                            builder: (context) => viewDialog(title: snapshot.data?.docs[index]['Title'],time: snapshot.data?.docs[index]['Time'], docID: snapshot.data!.docs[index].id),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: const Color(0xffD9DEDC),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                          )
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              margin: const EdgeInsets.only(right: 20),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                                color: Color(0xff219C9C),
                                              ),
                                              child: Center(
                                                child: DateFormat('HH:mm').parse(snapshot.data?.docs[index]['Time']).isBefore(DateFormat('HH:mm').parse("${TimeOfDay.now().hour}:${TimeOfDay.now().minute}") )?

                                                    Icon(Icons.warning_amber) :
                                                Text(
                                                  snapshot.data?.docs[index]['Time'],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data?.docs[index]['Title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                color: Color(0xff424242)
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  );
                                },
                              );
                            }),

                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
