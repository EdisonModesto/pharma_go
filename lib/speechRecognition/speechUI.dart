import 'package:flutter/material.dart';

import '../my_flutter_app_icons.dart';

class speechUI extends StatefulWidget {
  const speechUI({Key? key}) : super(key: key);

  @override
  State<speechUI> createState() => _speechUIState();
}

class _speechUIState extends State<speechUI> {
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
            onPressed: (){},
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
          const Text(
            "Speech Assistant",
            style: TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }
}
