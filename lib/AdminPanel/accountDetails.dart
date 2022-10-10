import 'package:flutter/material.dart';

import '../my_flutter_app_icons.dart';

class accountsDetails extends StatefulWidget {
  const accountsDetails({Key? key}) : super(key: key);

  @override
  State<accountsDetails> createState() => _accountsDetailsState();
}

class _accountsDetailsState extends State<accountsDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Account Details",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            "Name: User Name",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "ID: False",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Age: 22",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Height: 22",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Weight: 22",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Adress: Address",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Mobile: Mobile Number",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "Password: Password",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
