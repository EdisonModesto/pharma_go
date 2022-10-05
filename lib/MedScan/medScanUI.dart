import 'package:flutter/material.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';

class medScanUI extends StatefulWidget {
  const medScanUI({Key? key}) : super(key: key);

  @override
  State<medScanUI> createState() => _medScanUIState();
}

class _medScanUIState extends State<medScanUI> {

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
                      width: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 40,
                            child: Hero(
                              tag: "logo",
                              child: Image.asset("assets/images/PharmaGo_rounded.png"),

                            ),
                          ),
                          const Text(
                            "Welcome User",
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
                              "Scan Medicine",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                onPressed: (){},
                                icon: const Icon(
                                  MyFlutterApp.flash,
                                  color: Color(0xff424242),
                                )
                            )
                          ],
                        ),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 270,
                                  width: 270,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.black, width: 8,
                                    )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Color(0xffD9DEDC),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        backgroundColor: const Color(0xff219C9C),
        child: const Icon(
          MyFlutterApp.mic,
          size: 20,
        ),
      ),
    );
  }
}
