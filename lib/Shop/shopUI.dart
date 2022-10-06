import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/Shop/cartList.dart';
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
                            margin: EdgeInsets.only(right: 15),
                            width: 40,
                            child: Hero(
                              tag: "logo",
                              child: Image.asset("assets/images/PharmaGo_rounded.png"),

                            ),
                          ),
                          Text(
                            "Welcome ${context.watch<registerProvider>().Name.split(" ")[0]}",
                            style: TextStyle(
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20)
                                          )
                                      ),
                                      builder: (context) => cartList()
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
                        child: GridView.count(
                          padding: const EdgeInsets.only(left: 0, right: 0, top: 15),
                          crossAxisCount: 2,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 20,
                          children: List.generate(7, (index) {
                              return Container(
                                width: 145,
                                height: 145,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Color(0xffD9DEDC),
                                ),
                              );
                            },
                          ),
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
      floatingActionButton: const speechFAB()
    );
  }
}
