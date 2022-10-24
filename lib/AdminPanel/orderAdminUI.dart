

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/AdminPanel/numberUI.dart';
import 'package:pharma_go/AdminPanel/viewStats.dart';
import 'package:pharma_go/Shop/addItem.dart';
import 'package:pharma_go/AdminPanel/orderExpand.dart';
import 'package:pharma_go/Shop/shopUI.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:provider/provider.dart';

import '../notification/Notify.dart';

class orderAdminUI extends StatefulWidget {
  const orderAdminUI({Key? key}) : super(key: key);

  @override
  State<orderAdminUI> createState() => _orderAdminUIState();
}

class _orderAdminUIState extends State<orderAdminUI> {


  var order = FirebaseFirestore.instance.collection('Orders');

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
                            children: [
                              const Text(
                                "Orders",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
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
                                          builder: (context) => const numberUI(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.numbers,
                                        color: Color(0xff219C9C),
                                      )
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
                                          builder: (context) => const addItemUI(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Color(0xff424242),
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child:StreamBuilder(
                              stream: order.snapshots(),
                              builder: (context,snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const LoadingIndicator(
                                      size: 40, borderWidth: 2);
                                }

                                return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index){
                                      return Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                                                builder: (context) => orderExpand(snap: snapshot.data!.docs[index].id, snap1:snapshot.data!.docs[index] ,),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(MediaQuery.of(context).size.width, 100),
                                                backgroundColor: const Color(0xff219C9C)
                                            ),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Order #${index+1}",
                                                        style: const TextStyle(
                                                            fontSize: 16
                                                        ),
                                                      ),
                                                      Text(
                                                        "${snapshot.data!.docs[index]["Buyer"]}",
                                                        style: TextStyle(
                                                            fontSize: 14
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Status: ${snapshot.data!.docs[index]["Status"]}",
                                                        style: TextStyle(
                                                            fontSize: 16
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            )


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
