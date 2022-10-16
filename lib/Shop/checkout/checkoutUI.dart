import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../authentication/registerProvider.dart';
import '../../my_flutter_app_icons.dart';

class checkoutUI extends StatefulWidget {
  const checkoutUI({Key? key}) : super(key: key);

  @override
  State<checkoutUI> createState() => _checkoutUIState();
}

class _checkoutUIState extends State<checkoutUI> {
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
                            const Text(
                              "Checkout",
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
                          SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: const Placeholder(),
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 315,
                              padding: const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Color(0xffD9DEDC),
                              ),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Receipt",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1, color: Colors.grey,
                                    ),
                                    const Text(
                                      "Reference Number: 56df4sj64kf",
                                      style: TextStyle(
                                          fontSize: 12,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1, color: Colors.grey,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 4,
                                        itemBuilder: (context, index){
                                        return Container(
                                          height: 30,
                                          width: double.maxFinite,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Item Name"),
                                              Text("100")
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    const Divider(
                                      thickness: 1, color: Colors.grey,
                                    ),
                                    const Text(
                                      "Total: 400",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
