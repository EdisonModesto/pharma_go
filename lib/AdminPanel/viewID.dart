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
                      onPressed: (){},
                      child: const Text(
                        "Decline ID"
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        FirebaseFirestore.instance.collection('Users').doc(widget.id).update({
                          "isVerified": true
                        });
                        Navigator.pop(context);
                      },
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
