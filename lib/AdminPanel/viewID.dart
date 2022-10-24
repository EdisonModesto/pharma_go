import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class viewID extends StatefulWidget {
  const viewID({required this.url, required this.id, Key? key}) : super(key: key);
  final url;
  final id;
  @override
  State<viewID> createState() => _viewIDState();
}

class _viewIDState extends State<viewID> {



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
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        FirebaseFirestore.instance.collection('Users').doc(widget.id).update({
                          "isVerified": false
                        });
                      },
                      child: const Text(
                        "Decline ID"
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff219C9C)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        FirebaseFirestore.instance.collection('Users').doc(widget.id).update({
                          "isVerified": true
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff219C9C)
                      ),
                      child: const Text(
                          "Approve ID"
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
