import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

import '../Home/viewDialog.dart';
import '../authentication/registerProvider.dart';
import '../my_flutter_app_icons.dart';

class chatUI extends StatefulWidget {
  const chatUI({required this.channelID, required this.Name, Key? key}) : super(key: key);

  final String channelID;
  final String Name;

  @override
  State<chatUI> createState() => _chatUIState();
}

class _chatUIState extends State<chatUI> {

  CollectionReference messages = FirebaseFirestore.instance.collection('Channels');

  TextEditingController msgCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    msgCtrl.dispose();
  }

  void checkAutoMsg()async{
    var docu = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID);
    DateTime startDate = new DateTime.now().toLocal();
    var snap = await docu.get();
    int offset = await NTP.getNtpOffset(localTime: startDate);
    startDate.add(Duration(milliseconds: offset));


    var diff = startDate.difference(snap["lastUpdate"].toDate()).inMinutes;
    print(startDate.difference(snap["lastUpdate"].toDate()).inMinutes);
    
    if(diff > 15){
      print("AUTOREPLY SENT");
      messages.add({
        "message": "Hello! Thanks for visiting PharmaGo, we will be with you in just a moment.",
        "user": "AutoReplyBot",
        "time": startDate.add(Duration(milliseconds: offset))
      });
      var snap = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID).update({
        "lastUpdate": startDate.add(Duration(milliseconds: offset)),
      });
    }
  }

  @override
  void initState() {
    super.initState();
    messages = messages.doc(widget.channelID).collection("Messages");
    checkAutoMsg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Stack(
            children: [
                SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 9,
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
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff219C9C),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: const Icon(
                                      Icons.person,
                                      color: Color(0xffD9DEDC)
                                  ),
                                ),
                                Text(
                                  widget.Name == context.watch<registerProvider>().Name ? "PharmaGo" : widget.Name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff424242),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: StreamBuilder(
                            stream: messages.orderBy("time").snapshots(),
                            builder: (context,snapshot){
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const LoadingIndicator(size: 40, borderWidth: 2);
                              }

                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context,index){
                                  return snapshot.data?.docs[index]["user"] == FirebaseAuth.instance.currentUser?.uid ?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xff219C9C),
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10, left: 30),
                                          padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
                                          child: Text(
                                            snapshot.data?.docs[index]["message"],
                                            softWrap: true,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xffD9DEDC),
                                              borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10, right: 30),
                                          padding: const EdgeInsets.only(left: 15, right: 15,top: 10, bottom: 10),
                                          child: Text(
                                            snapshot.data?.docs[index]["message"],
                                            softWrap: true,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9DEDC),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: msgCtrl,
                              decoration: const InputDecoration(
                                hintText: "Message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              DateTime startDate = new DateTime.now().toLocal();
                              int offset = await NTP.getNtpOffset(localTime: startDate);
                              messages.add({
                                "message": msgCtrl.text,
                                "user": FirebaseAuth.instance.currentUser?.uid,
                                "time": startDate.add(Duration(milliseconds: offset))
                              });
                              var snap = FirebaseFirestore.instance.collection("Channels").doc(widget.channelID).update({
                                "lastUpdate": startDate.add(Duration(milliseconds: offset)),
                              });

                            },
                            icon: const Icon(Icons.send),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),

    );
  }
}
