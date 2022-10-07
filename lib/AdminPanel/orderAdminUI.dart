import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:provider/provider.dart';

class orderAdminUI extends StatefulWidget {
  const orderAdminUI({Key? key}) : super(key: key);

  @override
  State<orderAdminUI> createState() => _orderAdminUIState();
}

class _orderAdminUIState extends State<orderAdminUI> {
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

                                      },
                                      icon: const Icon(
                                        MyFlutterApp.cart,
                                        color: Color(0xff219C9C),
                                      )
                                  ),
                                  IconButton(
                                      onPressed: (){},
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
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index){
                              return Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  child: ElevatedButton(
                                    onPressed: (){},
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
                                              const Text(
                                                "Customer Name",
                                                style: TextStyle(
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Item Name",
                                                style: TextStyle(
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "Item Name",
                                                style: TextStyle(
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "Item Name",
                                                style: TextStyle(
                                                    fontSize: 14
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
                            }),
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
