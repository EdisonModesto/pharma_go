import 'package:flutter/material.dart';

class chatAdminUI extends StatefulWidget {
  const chatAdminUI({Key? key}) : super(key: key);

  @override
  State<chatAdminUI> createState() => _chatAdminUIState();
}

class _chatAdminUIState extends State<chatAdminUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("CHAT"),
      ),
    );
  }
}
