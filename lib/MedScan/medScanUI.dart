
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:pharma_go/speechRecognition/speechFAB.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:string_similarity/string_similarity.dart';
import '../notification/NotificationUI.dart';
import 'medScanProvider.dart';

class medScanUI extends StatefulWidget {
  const medScanUI({Key? key}) : super(key: key);

  @override
  State<medScanUI> createState() => _medScanUIState();
}

class _medScanUIState extends State<medScanUI> {

  // Create the CameraController
  late CameraController? _camera;
  late List<CameraDescription> _cameras;
  late var body;
  late Map responseMap;
  late List<String> KeyList = [];
  List<String> medName = [], brandName = [], dosage = [], srp = [];
  var flash = false;


  // Initializing the TextDetector
  final textDetector = TextRecognizer();
  String recognizedText = "";

  void _initializeCamera() async {
    var image = await _camera?.takePicture();
    _processCameraImage(image!);
  }


  void _processCameraImage(XFile image) async {
 // getting InputImage from CameraImage
    InputImage inputImage = InputImage.fromFile(File(image.path));
    final RecognizedText recognisedText = await textDetector.processImage(inputImage);
// Using the recognised text.
    for (TextBlock block in recognisedText.blocks) {
        recognizedText = block.text + " ";
        print(recognizedText);
    }

    var parsedText = recognizedText.split(" ");
    parsedText.addAll(recognizedText.split("\n"));
    parsedText.addAll(recognizedText.split("®"));

    for(int i = 0; i < body.length; i++){
      for(int j = 0; j < parsedText.length; j++){
        double? rating = StringSimilarity.findBestMatch(parsedText[j].toLowerCase(), KeyList).bestMatch.rating;
        String? matchedKey = StringSimilarity.findBestMatch(parsedText[j].toLowerCase(), KeyList).bestMatch.target;
        print("BEST MATCH IS $rating");

        if(rating! >= 0.3 && rating != 0){
          print("detextd");
          /*medName.add(body[matchedKey][0]["generic_name"]);
          brandName.add(body[matchedKey][1]["brand_name"]);
          dosage.add(body[matchedKey][2]["dosage"]);
          srp.add(body[matchedKey][3]["srp"]);*/
          print("added");
          for(int k = 0; k < body.length; k++){
            if(body[matchedKey][0]["generic_name"] == body[KeyList[k]][0]["generic_name"]){
              medName.add(body[KeyList[k]][0]["generic_name"]);
              brandName.add(body[KeyList[k]][1]["brand_name"]);
              dosage.add(body[KeyList[k]][2]["dosage"]);
              srp.add(body[KeyList[k]][3]["srp"]);
              print("added again");
            }
          }
          setState(() {
            print(medName);
            print(brandName);
            print(dosage);
          });
          break;
        }
      }
      if(medName.isNotEmpty){
        break;
      }
    }
  }

  void getJSon() async {
    final response = await http.get(Uri.parse('https://api.npoint.io/e63a328b19e2921d7e97'));
    body = jsonDecode(response.body);
    responseMap = body;

    responseMap.forEach((key, value) {
      KeyList.add(key);
    });
    print(KeyList);
  }


  void setupCam(){
    _camera?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      //_initializeCamera();
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    // App state changed before we got the chance to initialize.
    if (_camera == null || !_camera!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _camera!.dispose();
    } else if (state == AppLifecycleState.resumed) {

    }
  }


  @override
  void initState() {
    super.initState();

    _cameras =  context.read<medScanProvider>().cameras;
    _camera = CameraController(_cameras[0], ResolutionPreset.ultraHigh, imageFormatGroup: ImageFormatGroup.yuv420);
    getJSon();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      setupCam();
    });
  }


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
                              "Scan Medicine",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  if(flash){
                                    _camera!.setFlashMode(FlashMode.off);
                                  } else{
                                    _camera!.setFlashMode(FlashMode.torch);
                                  }
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
                                  child: !_camera!.value.isInitialized ?
                                  Container(
                                    child: Center(
                                      child: Text(
                                        "Camera Permission Required"
                                      ),
                                    ),
                                  ) :
                                  CameraPreview(
                                    _camera!,
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
                              padding: EdgeInsets.only(bottom: 0, top: 10, left: 10, right: 10),
                              decoration: const BoxDecoration(
                                color: Color(0xffD9DEDC),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                              ),
                              child: Column(
                                children: [

                                  Expanded(
                                    child: PageView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(medName.length, (index){
                                        return Container(
                                          height: 200,
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Medicine Name: ${medName[index]}"
                                              ),
                                              Text(
                                                  "Medicine Name: ${brandName[index]}"
                                              ),
                                              Text(
                                                  "Dosage: ${dosage[index]}"
                                              ),
                                              Text(
                                                  "SRP: ${srp[index]}"
                                              ),

                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        _initializeCamera();
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff219C9C)
                                      ),
                                      child: Text(
                                          "Capture"
                                      ),
                                    ),
                                  )
                                ],
                              )


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
