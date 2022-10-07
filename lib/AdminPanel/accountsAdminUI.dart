import 'package:flutter/material.dart';

class accountAdminUI extends StatefulWidget {
  const accountAdminUI({Key? key}) : super(key: key);

  @override
  State<accountAdminUI> createState() => _accountAdminUIState();
}

class _accountAdminUIState extends State<accountAdminUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("ACCOUNTS"),
      ),
    );
  }
}
