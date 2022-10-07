import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/Shop/cartList.dart';
import 'package:pharma_go/Shop/expandItem.dart';
import 'package:provider/provider.dart';

import '../authentication/registerProvider.dart';
import '../my_flutter_app_icons.dart';
import '../speechRecognition/speechFAB.dart';

class shopUI extends StatefulWidget {
  const shopUI({Key? key}) : super(key: key);

  @override
  State<shopUI> createState() => _shopUIState();
}

class _shopUIState extends State<shopUI> {

  CollectionReference shop = FirebaseFirestore.instance.collection('Shop');


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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shopping",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    showMaterialModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20)
                                          )
                                      ),
                                      builder: (context) => const cartList()
                                    );
                                  },
                                  icon: const Icon(
                                      MyFlutterApp.cart,
                                    color: Color(0xff219C9C),
                                  )
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: const Icon(
                                      MyFlutterApp.search,
                                      color: Color(0xff424242),
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: shop.snapshots(),
                          builder: (context,snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingIndicator(size: 40, borderWidth: 2);
                            }

                            return GridView.count(
                              padding: const EdgeInsets.only(left: 0, right: 0, top: 15),
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 20,
                              children: List.generate(snapshot.data!.docs.length, (index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                        builder: (context) => const expandItem(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      fixedSize: Size(145, 145)
                                    ),
                                    child: Container(
                                      color: Color(0xffD9DEDC),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12) ),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://images.unsplash.com/photo-1631549916768-4119b2e5f926?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1179&q=80"
                                                    ),

                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(
                                            height: 60,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data?.docs[index]['Heading'],
                                                  style: const TextStyle(
                                                      color: Color(0xff424242)
                                                  ),
                                                ),
                                                Text(
                                                    "Stocks: ${snapshot.data?.docs[index]['Stock']}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff424242)
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              ),
                            );
                          })
                      )
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
