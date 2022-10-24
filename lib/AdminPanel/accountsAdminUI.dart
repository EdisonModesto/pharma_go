import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/AdminPanel/viewStats.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:provider/provider.dart';

import '../my_flutter_app_icons.dart';
import 'accountDetails.dart';

class accountAdminUI extends StatefulWidget {
  const accountAdminUI({Key? key}) : super(key: key);

  @override
  State<accountAdminUI> createState() => _accountAdminUIState();
}

class _accountAdminUIState extends State<accountAdminUI> {

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

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
                          builder: (context) => const viewStats(),
                        );
                      },
                      icon: const Icon(
                        Icons.insert_chart_outlined_rounded,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Accounts",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: users.orderBy("Name").snapshots(),
                            builder: (context,snapshot){
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const LoadingIndicator(size: 40, borderWidth: 2);
                              }

                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index){
                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                                              builder: (context) => accountsDetails(snap: snapshot.data!.docs[index]),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(MediaQuery.of(context).size.width, 75),
                                              backgroundColor: const Color(0xffD9DEDC)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                margin: const EdgeInsets.only(right: 15),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff219C9C),
                                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                                ),
                                                child: const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]["Name"],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Color(0xff424242)
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Tap for more details",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xff424242)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        )
                      ]
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
