import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Home/viewDialog.dart';

class notifUI extends StatefulWidget {
  const notifUI({Key? key}) : super(key: key);

  @override
  State<notifUI> createState() => _notifUIState();
}

class _notifUIState extends State<notifUI> {

  var recipes = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection("Reminders").orderBy("parsedTime");


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Saved Reminders",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          Expanded(
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
                          height: 70,
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
                                  width: 70,
                                  height: 70,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    color: Color(0xff219C9C),
                                  ),
                                  child: Center(
                                    child: Text(
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
    );
  }
}
