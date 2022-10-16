import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pharma_go/Shop/checkout/checkoutUI.dart';

import 'expandItem.dart';

class cartList extends StatefulWidget {
  const cartList({Key? key}) : super(key: key);

  @override
  State<cartList> createState() => _cartListState();
}

class _cartListState extends State<cartList> {

  var shop = FirebaseFirestore.instance.collection('Shop');
  CollectionReference Cart = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection("Cart");


  getFunc(snap)async{
    var item = await shop.doc(snap).get();
    return item.data();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Cart",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: (){
                  Cart.get().then((value){
                    for (DocumentSnapshot ds in value.docs){
                      ds.reference.delete();
                    };
                  });
                },
                child: Text(
                  "Clear All"
                ),
              )
            ],
          ),
          Expanded(
              child: StreamBuilder(
                  stream: Cart.snapshots(),
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
                        String head = "";
                        print(snapshot.data!.docs[index]["Item"]);
                        var item = getFunc(snapshot.data!.docs[index]["Item"]);


                        return StreamBuilder(
                          stream: shop.doc(snapshot.data!.docs[index]["Item"]).snapshots(),
                          builder: (context,snapshot1) {
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
                                    builder: (context) => expandItem(heading: snapshot1.data!['Heading'], price: snapshot1.data!['Price'], stocks: snapshot1.data!['Stock'], desc: snapshot1.data!['Description'], id: snapshot1.data!.id,),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    fixedSize: Size(125, 125)
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapshot1.data!['Heading'],
                                                style: const TextStyle(
                                                    color: Color(0xff424242)
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
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
                        );
                      }),
                    );
                  })
          ),
          ElevatedButton(
            onPressed: (){
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: checkoutUI(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(409, 53),
                backgroundColor: const Color(0xff219C9C),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))
                )
            ),
            child: const Text(
                "Check Out"
            ),
          ),
        ],
      ),
    );
  }
}
