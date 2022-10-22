
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/authentication/registerProvider.dart';
import 'package:pharma_go/my_flutter_app_icons.dart';
import 'package:pharma_go/speechRecognition/speechFAB.dart';
import 'package:provider/provider.dart';


import '../notification/NotificationUI.dart';
import 'medScanProvider.dart';

class medScanUI extends StatefulWidget {
  const medScanUI({Key? key}) : super(key: key);

  @override
  State<medScanUI> createState() => _medScanUIState();
}

class _medScanUIState extends State<medScanUI> {

/*  // Create the CameraController
  late CameraController? _camera;
  late List<CameraDescription> _cameras;


  // Initializing the TextDetector
  final textDetector = GoogleMlKit.vision.textRecognizer();
  String recognizedText = "";*/

  /*void _initializeCamera() async {

    await _camera?.startImageStream((CameraImage image) => _processCameraImage(image));  // image processing and text recognition.
  }*/


  //void _processCameraImage(CameraImage image) async {
/*// getting InputImage from CameraImage
    InputImage inputImage = getInputImage(image);
    final RecognizedText recognisedText = await textDetector.processImage(inputImage);
// Using the recognised text.
    for (TextBlock block in recognisedText.blocks) {
        recognizedText = block.text + " ";
    }
  }

  InputImage getInputImage(CameraImage cameraImage) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

    final InputImageRotation imageRotation = InputImageRotation.rotation0deg;

    final InputImageFormat inputImageFormat = InputImageFormatValue.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.nv21;

    final planeData = cameraImage.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  }

  void setupCam(){
    _camera?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _initializeCamera();
    //  setState(() {});
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
  }*/


  @override
  void initState() {
    super.initState();

    /*_cameras =  context.read<medScanProvider>().cameras;
    _camera = CameraController(_cameras[0], ResolutionPreset.medium, imageFormatGroup: ImageFormatGroup.yuv420);
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      setupCam();
    });*/
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
                                  child:// !_camera!.value.isInitialized ?
                                  Container(
                                    child: Center(
                                      child: Text(
                                        "Camera Permission Required"
                                      ),
                                    ),
                                  )
                                 /* CameraPreview(
                                    _camera!,
                                  ),*/
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
                                child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Medicine Name: "
                                        ),
                                        Text(
                                            "Dosage: "
                                        ),
                                        Text(
                                            "SRP: "
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xff219C9C)
                                            ),
                                            child: Text(
                                              "Capture"
                                            ),
                                          ),
                                        ),
                                      ],
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
