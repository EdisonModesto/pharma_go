import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';

import '../authentication/registerProvider.dart';
import '../my_flutter_app_icons.dart';
import '../notification/NotificationUI.dart';
import '../speechRecognition/speechFAB.dart';

class qrUI extends StatefulWidget {
  const qrUI({Key? key}) : super(key: key);

  @override
  State<qrUI> createState() => _qrUIState();
}

class _qrUIState extends State<qrUI> {
  ScanController controller = ScanController();
  var name = "";
  var mobile = "";
  var age = "";

  void parseQR(String data){
    var splitData = data.split(":");

    try{
      setState(() {
        name = splitData[0];
        mobile = splitData[1];
        age = splitData[2];
      });
      print(name);
      print(mobile);
      print(age);
    }catch(e){
      print("incorrectQR");
    }

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
                                "Scan QR CODE",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: (){

                                  },
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
                                    child: ScanView(
                                      controller: controller,
// custom scan area, if set to 1.0, will scan full area
                                      scanAreaScale: .7,
                                      scanLineColor: Colors.green.shade400,
                                      onCapture: (data) {
                                        debugPrint('Barcode found! $data');
                                        parseQR(data);
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  color: Color(0xffD9DEDC),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Name: $name",
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "Number: $mobile",
                                        ),
                                        Text(
                                          "Age: $age",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
        floatingActionButton: const speechFAB()
    );
  }
}
