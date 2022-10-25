import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharma_go/MedScan/medScanUI.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../my_flutter_app_icons.dart';

class speechUI extends StatefulWidget {
  const speechUI({Key? key}) : super(key: key);

  @override
  State<speechUI> createState() => _speechUIState();
}

class _speechUIState extends State<speechUI> {
  CollectionReference reminders = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).collection("Reminders");

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async{
    setState(() {
      _lastWords = result.recognizedWords;
    });
    TextToSpeech tts = TextToSpeech();
    if(_lastWords.contains("what time do i take another pill")){
      print("RECOGNIZED");
      var snap = await reminders.orderBy("parsedTime").get();
      var title = snap.docs.elementAt(0)["Title"];
      var time = snap.docs.elementAt(0)["Time"];

      tts.speak("Your next scheduled reminder is at $time with a title of $title");
    } else if(_lastWords.contains("how much is this certain medicine")){
      tts.speak("Opening Medicine Scanner");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>medScanUI()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              if(_speechToText.isNotListening){
                _startListening();
              } else{
                _stopListening();
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff219C9C),
                fixedSize: const Size(60, 60),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                )
            ),
            child: const Icon(
              MyFlutterApp.mic,
              size: 20,
            ),
          ),
          Text(
            _speechToText.isListening
                ? '$_lastWords'
                : _speechEnabled
                ? 'Tap the microphone to start listening...'
                : 'Speech not available',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }
}
