import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import '../my_flutter_app_icons.dart';

class speechUI extends StatefulWidget {
  const speechUI({Key? key}) : super(key: key);

  @override
  State<speechUI> createState() => _speechUIState();
}

class _speechUIState extends State<speechUI> {

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
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
            style: TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }
}
