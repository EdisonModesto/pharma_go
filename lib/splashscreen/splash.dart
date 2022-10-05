import 'package:flutter/material.dart';

class splashUI extends StatefulWidget {
  const splashUI({Key? key}) : super(key: key);

  @override
  State<splashUI> createState() => _splashUIState();
}

class _splashUIState extends State<splashUI> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
          "assets/images/PharmaGo.png"
      ),
    );
  }
}
