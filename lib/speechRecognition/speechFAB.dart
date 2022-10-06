import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pharma_go/speechRecognition/speechUI.dart';

import '../my_flutter_app_icons.dart';

class speechFAB extends StatefulWidget {
  const speechFAB({Key? key}) : super(key: key);

  @override
  State<speechFAB> createState() => _speechFABState();
}

class _speechFABState extends State<speechFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showMaterialModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)
              )
          ),
          context: context,
          builder: (context) => const speechUI(),
        );
      },
      backgroundColor: const Color(0xff219C9C),
      child: const Icon(
        MyFlutterApp.mic,
        size: 20,
      ),
    );
  }
}
