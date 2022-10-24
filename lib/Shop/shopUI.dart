import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/Shop/cartList.dart';
import 'package:pharma_go/Shop/expandItem.dart';
import 'package:provider/provider.dart';

import '../authentication/registerProvider.dart';
import '../my_flutter_app_icons.dart';
import '../notification/NotificationUI.dart';
import '../speechRecognition/speechFAB.dart';

class shopUI extends StatefulWidget {
  const shopUI({Key? key}) : super(key: key);

  @override
  State<shopUI> createState() => _shopUIState();
}

class _shopUIState extends State<shopUI> {

  CollectionReference shop = FirebaseFirestore.instance.collection('Shop');

  Future<String> getURL(var ref)async{

    String url = await ref.getDownloadURL();
    return url;
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
                                late var ref = FirebaseStorage.instance.ref("shopImages/${snapshot.data?.docs[index].id}").child('itemImage/');
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
                                        builder: (context) => expandItem(heading: snapshot.data?.docs[index]['Heading'], price: snapshot.data?.docs[index]['Price'], stocks: snapshot.data?.docs[index]['Stock'], desc: snapshot.data?.docs[index]['Description'], id: snapshot.data!.docs[index].id,),
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
                                            child: FutureBuilder<String>(
                                              future: getURL(ref),
                                              builder: (context, AsyncSnapshot<String> snapshot){
                                                if(snapshot.hasData){
                                                  return ClipRRect(
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12) ),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${snapshot.data}"
                                                          ),

                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else{
                                                  return const LoadingIndicator(size: 40, borderWidth: 2);
                                                }
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 60,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15, right: 15),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data?.docs[index]['Heading'],
                                                    style: const TextStyle(
                                                        color: Color(0xff424242)
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                      "Stocks: ${snapshot.data?.docs[index]['Stock']}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff424242)
                                                    ),
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
