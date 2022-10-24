
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class medScanProvider with ChangeNotifier{
  late List<CameraDescription> cameras;
  String lastWord = "";

  void setCameras(p1){
    cameras = p1;
    notifyListeners();
  }

  void setWord(str){
    lastWord = str;
    notifyListeners();
  }
}