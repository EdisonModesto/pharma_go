import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class viewReseta extends StatefulWidget {
  const viewReseta({required this.url, required this.id, Key? key}) : super(key: key);
  final url;
  final id;

  @override
  State<viewReseta> createState() => _viewResetaState();
}

class _viewResetaState extends State<viewReseta> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Image.network(widget.url)
              )
            ],
          ),
        ),
      ),
    );
  }
}
